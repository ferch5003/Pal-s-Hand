import 'package:flutter/material.dart';
import 'package:pals_hand/ui/views/home/friends_list_view.dart';
import 'package:pals_hand/ui/views/home/my_list_view.dart';
import 'package:pals_hand/ui/views/home/settings_view.dart';
import 'package:pals_hand/ui/views/home/shopping_view.dart';

class TabRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'home/my_list':
        return MaterialPageRoute(builder: (_) => MyListView());
      case 'home/friends_list':
        return MaterialPageRoute(builder: (_) => FriendListView());
      case 'home/shopping':
        return MaterialPageRoute(builder: (_) => ShoppingView());
      case 'home/settings':
        return MaterialPageRoute(builder: (_) => SettingsView());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('Esta pagina no existe ${settings.name}'),
            ),
          );
        });
    }
  }
}
