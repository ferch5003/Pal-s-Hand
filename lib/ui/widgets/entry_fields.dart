import 'package:flutter/material.dart';

class EntryFields extends StatelessWidget {
  final String title;
  final bool isPassword;
  final TextEditingController textEditingController;

  EntryFields({key, this.title, this.isPassword, this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              controller: textEditingController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter the $title';
                } else if (!value.contains('@')) {
                  return 'use the @ char.';
                }
                return null;
              },
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true)),
        ],
      ),
    );
  }
}
