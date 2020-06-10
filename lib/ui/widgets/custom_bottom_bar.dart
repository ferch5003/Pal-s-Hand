import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pals_hand/core/viewmodels/home/home_view_model.dart';

class CustomBottomBar extends StatelessWidget {
  final HomeViewModel model;
  final GlobalKey<NavigatorState> navigationKey;

  CustomBottomBar({Key key, this.model, this.navigationKey});

  @override
  Widget build(BuildContext context) {
    GlobalKey _bottomNavigationKey = GlobalKey();

    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      color: Colors.orange[400],
      backgroundColor: Colors.white,
      index: model.index,
      height: MediaQuery.of(context).size.height * 0.09,
      items: <Widget>[
        Icon(Icons.person, size: 30),
        Icon(Icons.people, size: 30),
        Icon(Icons.list, size: 30),
        Icon(Icons.settings, size: 30),
      ],
      onTap: (index) {
        model.changeTab(index);
        switch (index) {
          case 0:
            navigationKey.currentState.pushReplacementNamed('home/my_list');
            break;
          case 1:
            navigationKey.currentState.pushReplacementNamed('home/friends_list');
            break;
          case 2:
            navigationKey.currentState.pushReplacementNamed('home/shopping');
            break;
          case 3:
            navigationKey.currentState.pushReplacementNamed('home/settings');
            break;
        }
      },
    );
  }
}
