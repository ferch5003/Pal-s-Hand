import 'package:flutter/material.dart';

class SubmitButtonGoogle extends StatelessWidget {
  final VoidCallback callback;

  SubmitButtonGoogle({this.callback});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        onPressed: () async => callback(),
        padding: const EdgeInsets.all(0.0),
        child: Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
            ),
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/google_logo_72.png',
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text('Login with Google',
                      style: TextStyle(fontSize: 20, color: Colors.black45)),
                ),
              ],
            )));
  }
}
