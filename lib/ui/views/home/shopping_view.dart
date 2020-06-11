import 'package:flutter/material.dart';
import 'package:pals_hand/core/models/product.dart';
import 'package:pals_hand/core/models/user.dart';
import 'package:pals_hand/core/viewmodels/base_view.dart';
import 'package:pals_hand/core/viewmodels/home/shopping_view_model.dart';
import 'package:pals_hand/ui/views/home/ready_view.dart';
import 'package:pals_hand/ui/views/home/waiting_view.dart';

class ShoppingView extends StatefulWidget {
  @override
  _ShoppingViewState createState() => _ShoppingViewState();
}

class _ShoppingViewState extends State<ShoppingView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<ShoppingViewModel>(
      builder: (context, model, child) => FutureBuilder<Map<String, dynamic>>(
        future: model.getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            default:
              if (snapshot.hasData) {
                User user = snapshot.data['user'];
                User friend = snapshot.data['friend'];
                List<Product> myProds = snapshot.data['myProds'];
                List<Product> friendProds = snapshot.data['friendProds'];
                VoidCallback callback = () {
                  model.updateView();
                };

                return snapshot.data['ready']
                    ? ReadyView(
                        myUser: user,
                        friendUser: friend,
                        myProducts: myProds,
                        friendProducts: friendProds,
                        callback: callback,
                      )
                    : WaitingView(
                        myUser: user,
                        friendUser: friend,
                        myProducts: myProds,
                        friendProducts: friendProds,
                        callback: callback,
                      );
              } else if (snapshot.hasError) {
                return Center(child: Text('ERROR: ${snapshot.error}'));
              }
              return Center(
                child: Text('No hay datos'),
              );
          }
        },
      ),
    );
  }
}
