import 'package:pals_hand/core/enums/viewstate.dart';
import 'package:pals_hand/ui/widgets/image_category.dart';
import 'package:flutter/material.dart';
import 'package:pals_hand/core/viewmodels/base_view.dart';
import 'package:pals_hand/core/viewmodels/home/shopping_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../locator.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ShoppingView extends StatefulWidget {
  @override
  _ShoppingViewState createState() => _ShoppingViewState();
}

class _ShoppingViewState extends State<ShoppingView> {
  Future<List<Map<dynamic, dynamic>>> _myProducts;
  Future<List<Map<dynamic, dynamic>>> _myFriendProducts;

  Future<QuerySnapshot> _allUsersData;

  @override
  void initState() {
    super.initState();

    _allUsersData = locator<ShoppingViewModel>().getAllUsersData();
  }

  bool pressGeoON = false;
  bool cmbscritta = false;

  @override
  Widget build(BuildContext context) {
    return BaseView<ShoppingViewModel>(
      builder: (context, model, child) => Scaffold(
          body: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 50,
                  color: Colors.transparent,
                  child: Row(
                    children: <Widget>[
                      AutoSizeText('Shopping Tab'),
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: FutureBuilder(
                  future: FirebaseAuth.instance.currentUser(),
                  builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
                    if (snapshot.hasData) {
                      String userID = snapshot.data.uid;
                      return FutureBuilder<QuerySnapshot>(
                          future: _allUsersData,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<DocumentSnapshot> values =
                                  snapshot.data.documents;

                              String userName;
                              double total;
                              String thumbnail;
                              String friendList;
                              values.forEach((element) {
                                if (element["uid"] == userID) {
                                  userName = element['name'];
                                  total = element['total'];
                                  thumbnail = element['image'];
                                  friendList = element['friend_list'];
                                }
                              });

                              if (total == null) {
                                total = 0;
                              }

                              int contador = 3;
                              if (friendList == "" || friendList == null) {
                                contador = 2;
                              }

                              String friendUserName;
                              double friendTotal;
                              String friendThumbnail;

                              values.forEach((element) {
                                if (element["uid"] == friendList) {
                                  friendUserName = element['name'];
                                  friendTotal = element['total'];
                                  friendThumbnail = element['image'];
                                }
                              });

                              _myProducts =
                                  locator<ShoppingViewModel>().getMyProducts();

                              _myFriendProducts = locator<ShoppingViewModel>()
                                  .getMyFriendProducts();

                              return new ListView.builder(
                                shrinkWrap: true,
                                itemCount: contador,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index == 0) {
                                    return FutureBuilder<
                                            List<Map<dynamic, dynamic>>>(
                                        future: _myProducts,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return CustomListItem(
                                              name: userName,
                                              total: total,
                                              thumbnail: thumbnail,
                                              items: snapshot.data,
                                            );
                                          } else {
                                            return Container();
                                          }
                                        });
                                  }
                                  if (index == contador - 1) {
                                    return Center(
                                      child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      18.0),
                                              side: BorderSide(
                                                  color: Colors.red)),
                                          color: pressGeoON
                                              ? Colors.blue
                                              : Colors.red,
                                          textColor: Colors.white,
                                          child: cmbscritta
                                              ? Text("Finalize")
                                              : Text("Close"),
                                          onPressed: () {
                                            setState(() {
                                              pressGeoON = !pressGeoON;
                                              cmbscritta = !cmbscritta;
                                            });
                                          }),
                                    );
                                  }
                                  if (index == 1) {
                                    return FutureBuilder<
                                            List<Map<dynamic, dynamic>>>(
                                        future: _myFriendProducts,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return CustomListItem(
                                              name: friendUserName,
                                              total: friendTotal,
                                              thumbnail: friendThumbnail,
                                              items: snapshot.data,
                                            );
                                          } else {
                                            return Container();
                                          }
                                        });
                                  }

                                  return Container();
                                },
                              );
                            }
                            return Container(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(),
                            );
                          });
                    } else {
                      return Container();
                    }
                  }),
            )
          ],
        ),
      )),
    );
  }
}

class _ItemDescription extends StatelessWidget {
  _ItemDescription({
    Key key,
    this.name,
    this.total,
    this.thumbnail,
    this.items,
  }) : super(key: key);

  final String name;
  final double total;
  final String thumbnail;
  final List<Map<dynamic, dynamic>> items;

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      shrinkWrap: true,
      itemCount: items.length + 2,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text(name),
                ),
              ],
            ),
          );
        }
        if (index == 1) {
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text('Total: ' + total.toString()),
                ),
              ],
            ),
          );
        }
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                  leading: CircleAvatar(
                    child: Stack(
                      children: <Widget>[
                        ImageCategory(
                            category: items[index - 2]['product'].category)
                      ],
                    ),
                    backgroundColor: Colors.orange,
                  ),
                  title: Row(children: <Widget>[
                    new Expanded(
                        flex: 8,
                        child: new Text(items[index - 2]['product'].name)),
                    new Expanded(
                        flex: 2,
                        child: new Text('x' +
                            items[index - 2]['product'].quantity.toString())),
                  ]),
                  subtitle: Text('Subtotal: ' +
                      (items[index - 2]['product'].price *
                              items[index - 2]['product'].quantity)
                          .toString())),
            ],
          ),
        );
      },
    );
  }
}

class CustomListItem extends StatelessWidget {
  CustomListItem({
    Key key,
    this.name,
    this.total,
    this.thumbnail,
    this.items,
  }) : super(key: key);

  final String name;
  final double total;
  final String thumbnail;
  final List<Map<dynamic, dynamic>> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 230,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                width: 90,
                height: 90,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.fill, image: new NetworkImage(thumbnail)))),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 2.0, 0.0),
                child: _ItemDescription(
                  name: name,
                  total: total,
                  thumbnail: thumbnail,
                  items: items,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
