import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pals_hand/core/enums/viewstate.dart';
import 'package:pals_hand/core/models/user.dart';
import 'package:pals_hand/core/viewmodels/base_view.dart';
import 'package:pals_hand/core/viewmodels/home/friends_list_view_model.dart';

class FriendListView extends StatefulWidget {
  @override
  _FriendListViewState createState() => _FriendListViewState();
}

class _FriendListViewState extends State<FriendListView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<FriendsListViewModel>(
      builder: (context, model, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 50,
                    color: Colors.transparent,
                    margin: const EdgeInsets.only(top: 23),
                    child: model.state == ViewState.Busy
                        ? Container()
                        : FutureBuilder<bool>(
                            future: model.isReady(),
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return Container();
                                default:
                                  if (snapshot.hasData) {
                                    bool ready = snapshot.data;
                                    return Row(children: <Widget>[
                                      Container(
                                        child: ready
                                            ? Text(
                                                'Ya tiene un pedido en proceso')
                                            : Text('Seleccione a un amigo'),
                                      ),
                                      Container(
                                          child: ready
                                              ? Icon(Icons.block)
                                              : Icon(Icons.account_circle))
                                    ]);
                                  } else if (snapshot.hasError) {}
                                  return Container();
                              }
                            },
                          ),
                  ),
                ],
              ),
              Expanded(
                flex: 1,
                child: AutoSizeText(
                  'Lista de amigos',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                ),
              ),
              Expanded(
                flex: 8,
                child: model.state == ViewState.Busy
                    ? Center(child: CircularProgressIndicator())
                    : FutureBuilder<List<Map<dynamic, dynamic>>>(
                        future: model.getUsers(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            default:
                              if (snapshot.hasData) {
                                return new ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    User user = snapshot.data[index]['user'];
                                    bool chosen =
                                        snapshot.data[index]['chosen'];

                                    var price =
                                        (user.total != 0 && user.total != null)
                                            ? user.total.toInt()
                                            : user.total;

                                    return Card(
                                      semanticContainer: true,
                                      color: chosen
                                          ? model.ready
                                              ? Colors.orange[100]
                                              : Colors.orange[300]
                                          : model.ready
                                              ? Colors.grey[200]
                                              : Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          ListTile(
                                            leading: CircleAvatar(
                                              backgroundImage: ['', null]
                                                      .contains(user.image)
                                                  ? AssetImage(
                                                      'assets/users.png')
                                                  : NetworkImage(user.image),
                                              backgroundColor: Colors.orange,
                                            ),
                                            title: Text(user.name),
                                            subtitle: (user.total != 0 &&
                                                    user.total != null)
                                                ? Text('\$ $price')
                                                : Text(
                                                    'Aún no tengo lista de productos'),
                                            onTap: model.ready
                                                ? null
                                                : () {
                                                    model.updateFriendListData(
                                                        user.uid);
                                                  },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('ERROR: ${snapshot.error}'));
                              }
                              return Container();
                          }
                        }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
