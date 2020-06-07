import 'package:flutter/material.dart';

class SubmitButtonRegister extends StatelessWidget {
  final VoidCallback callback;

  SubmitButtonRegister({this.callback});

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
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xfffbb448), Color(0xfff7892b)]),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Text('Register',
                style: TextStyle(fontSize: 20, color: Colors.white))));
  }
}
