import 'package:flutter/material.dart';
import 'package:pals_hand/core/viewmodels/base_view.dart';
import 'package:pals_hand/core/viewmodels/home/shopping_view_model.dart';

class ShoppingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<ShoppingViewModel>(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text('Shopping'),
        ),
      ),
    );
  }
}
