import 'package:flutter/material.dart';
import 'package:pals_hand/core/viewmodels/home/add_product_view_model.dart';

class SearchTextField extends StatelessWidget {
  final AddProductViewModel model;

  SearchTextField({key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: TextField(
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black54,
            ),
            hintText: 'Buscar producto',
            border: InputBorder.none,
            fillColor: Color(0xfff3f3f4),
            filled: true),
        onChanged: (q) => model.searchProducts(q),
      ),
    );
  }
}
