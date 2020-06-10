import 'package:flutter/material.dart';
import 'package:pals_hand/core/viewmodels/home/add_product_view_model.dart';

class CategoryDropdownMenu extends StatelessWidget {
  final AddProductViewModel model;

  CategoryDropdownMenu({key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: DropdownButton<String>(
        elevation: 4,
        value: model.selectedDropdown,
        items: <String>[
          'Categoria',
          'Carne',
          'Despensa',
          'Fruta',
          'Lacteo',
          'Limpieza',
          'Salud',
          'Verdura'
        ].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (selectedCategory) => model.changeCategory(selectedCategory),
      ),
    );
  }
}
