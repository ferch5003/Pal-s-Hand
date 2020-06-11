import 'package:flutter/material.dart';
import 'package:pals_hand/core/models/product.dart';
import 'package:pals_hand/core/models/user.dart';
import 'package:pals_hand/core/viewmodels/base_view.dart';
import 'package:pals_hand/core/viewmodels/home/waiting_view_model.dart';

class WaitingView extends StatefulWidget {
  final List<Product> myProducts;
  final List<Product> friendProducts;
  final User myUser;
  final User friendUser;

  final VoidCallback callback;

  WaitingView({
    key,
    this.myProducts,
    this.friendProducts,
    this.callback,
    this.myUser,
    this.friendUser,
  }) : super(key: key);
  @override
  _WaitingViewState createState() => _WaitingViewState();
}

class _WaitingViewState extends State<WaitingView> {
  Future<void> productsModal(List<Product> products) async {
    await showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0))),
        builder: (context) {
          return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                Product product = products[index];

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '${product.name} x ${product.quantity}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            'Categoria: ${product.category}',
                            style: TextStyle(
                                color: Color(0xFFC1BACB),
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                        ],
                      ),
                      Text(
                        '\$${product.price}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      )
                    ],
                  ),
                );
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<WaitingViewModel>(
        builder: (context, model, child) => Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 50,
                    color: Colors.transparent,
                    margin: const EdgeInsets.only(top: 23),
                  )
                ],
              ),
              Container(
                  child: Text(
                'Realizar compras',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              )),
              Container(
                  child: Text(
                'Mi Lista',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Card(
                      elevation: 3,
                      color: Colors.orange[200],
                      semanticContainer: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 15.0,
                          left: 15.0,
                          right: 20.0,
                        ),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage:
                                      ['', null].contains(widget.myUser.image)
                                          ? AssetImage('assets/users.png')
                                          : NetworkImage(widget.myUser.image),
                                  backgroundColor: Colors.orange,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    widget.myUser.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                widget.myUser.total == null
                                    ? Text(
                                        'Total \$0',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        'Total \$${widget.myUser.total}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                FlatButton(
                                  child: Text(
                                    'Ver lista',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: (widget.myUser == null ||
                                          widget.myUser.total == 0)
                                      ? null
                                      : () {
                                          productsModal(widget.myProducts);
                                        },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  child: Text(
                'Lista de mi amigo',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Card(
                      elevation: 3,
                      color: Colors.orange[200],
                      semanticContainer: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 15.0,
                          left: 15.0,
                          right: 20.0,
                        ),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: widget.friendUser == null
                                      ? AssetImage('assets/users.png')
                                      : ['', null]
                                              .contains(widget.friendUser.image)
                                          ? AssetImage('assets/users.png')
                                          : NetworkImage(
                                              widget.friendUser.image),
                                  backgroundColor: Colors.orange,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: widget.friendUser == null
                                      ? Text(
                                          'No ha seleccionado a un amigo',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0),
                                        )
                                      : Text(
                                          widget.friendUser.name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0),
                                        ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                widget.friendUser == null
                                    ? Text(
                                        'No hay valor',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        'Total \$${widget.friendUser.total}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                FlatButton(
                                  child: Text(
                                    'Ver lista',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: widget.friendUser == null
                                      ? null
                                      : widget.friendUser.total == 0
                                          ? null
                                          : () async {
                                              productsModal(
                                                  widget.friendProducts);
                                            },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Container(
                  width: 150,
                  height: 50,
                  child: MaterialButton(
                    color: Colors.orange[100],
                    disabledColor: Colors.orange[50],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text('CERRAR',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: (widget.myUser.total == 0 ||
                            widget.friendUser.total == 0)
                        ? null
                        : () {
                            model.deliveryReady();
                            widget.callback();
                          },
                  ),
                ),
              )
            ])));
  }
}
