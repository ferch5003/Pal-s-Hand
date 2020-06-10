import 'package:flutter/material.dart';

class ImageCategory extends StatelessWidget {
  final String category;

  ImageCategory({key, @required this.category});

  static const Map<String, Color> _categoryColor = {
    'CARNE': Color(0xFFFFE2DB),
    'DESPENSA': Color(0xFFFFECB3),
    'FRUTA': Color(0xFFE1BEE7),
    'LACTEO': Color(0xFFFFF9C4),
    'LIMPIEZA': Color(0xFFBBDEFB),
    'SALUD': Color(0xFFE1F5FE),
    'VERDURA': Color(0xFFE9F7EC)
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _categoryColor[category],
        borderRadius: BorderRadius.circular(20.0),
        image: DecorationImage(
            image: AssetImage('assets/$category.png'), fit: BoxFit.scaleDown),
      ),
    );
  }
}