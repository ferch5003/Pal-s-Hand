import 'package:flutter/material.dart';
import 'package:pals_hand/ui/views/home/home_view.dart';
import 'package:pals_hand/ui/views/login/login_view.dart';
import 'package:pals_hand/ui/views/signup/signup_view.dart';

class MainRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'home':
        return MaterialPageRoute(builder: (_) => HomeView());
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginView());
      case 'signup':
        return MaterialPageRoute(builder: (_) => SignupView());
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
