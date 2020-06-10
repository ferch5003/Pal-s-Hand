import 'package:flutter/material.dart';

class YellowCircles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [1, 1, 1, 1, 1]
          .map((circle) => Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    color: Color(0xFFFBBB00),
                    borderRadius: BorderRadius.circular(30.0)),
              ))
          .toList(),
    );
  }
}
