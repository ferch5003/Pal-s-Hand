import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pals_hand/ui/main_router.dart';
import 'package:pals_hand/ui/managers/dialog_manager.dart';
import 'package:pals_hand/ui/views/home/home_view.dart';
import 'package:pals_hand/ui/views/login/login_view.dart';
import 'core/services/authentication_service.dart';
import 'core/services/dialog_service.dart';
import 'core/services/navigation_service.dart';
import 'locator.dart';

void main() {
  setupLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    final textTheme = Theme.of(context).textTheme;
    final user = locator<AuthenticationService>().user;

    return MaterialApp(
        title: 'Pal\'s Hand',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
          textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
            body1: GoogleFonts.montserrat(textStyle: textTheme.body1),
          ),
        ),
        builder: (context, child) => Navigator(
              key: locator<DialogService>().dialogNavigationKey,
              onGenerateRoute: (settings) => MaterialPageRoute(
                  builder: (context) => DialogManager(child: child)),
            ),
        navigatorKey: locator<NavigationService>().navigationKey,
        onGenerateRoute: MainRouter.generateRoute,
        home: StreamBuilder<FirebaseUser>(
          stream: user,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              default:
                if (snapshot.hasData) {
                  if (snapshot.data.providerData.length == 1) {
                    return snapshot.data.isEmailVerified
                        ? HomeView()
                        : LoginView();
                  } else {
                    return HomeView();
                  }
                }
                return LoginView();
            }
          },
        ));
  }
}
