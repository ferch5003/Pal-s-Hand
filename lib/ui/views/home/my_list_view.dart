import 'package:flutter/material.dart';
import 'package:pals_hand/core/viewmodels/base_view.dart';
import 'package:pals_hand/core/viewmodels/home/my_list_view_model.dart';

class MyListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<MyListViewModel>(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text('My List'),
        ),
      ),
    );
  }
}
