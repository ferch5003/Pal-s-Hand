import 'package:flutter/material.dart';
import 'package:pals_hand/core/models/user.dart';
import 'package:pals_hand/core/viewmodels/base_view.dart';
import 'package:pals_hand/core/viewmodels/home/settings_view_model.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<SettingsViewModel>(
      builder: (context, model, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 50,
                color: Colors.transparent,
                margin: const EdgeInsets.only(top: 23),
              ),
              Container(
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    'Cuenta',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  )),
              FutureBuilder<User>(
                  future: model.getUser(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return CircularProgressIndicator();
                        break;
                      default:
                        if (snapshot.hasData) {
                          User user = snapshot.data;
                          return Row(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage: ['', null].contains(user.image)
                                    ? AssetImage('assets/users.png')
                                    : NetworkImage(user.image),
                                backgroundColor: Colors.orange,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Text(
                                  user.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0),
                                ),
                              )
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Container();
                        }
                        return Container();
                    }
                  }),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 60.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: MaterialButton(
                      color: Colors.orange[100],
                      disabledColor: Colors.orange[50],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () => model.logout(),
                      child: Text(
                        'Salir',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
