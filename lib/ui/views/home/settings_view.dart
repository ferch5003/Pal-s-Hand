import 'package:flutter/material.dart';
import 'package:pals_hand/core/viewmodels/base_view.dart';
import 'package:pals_hand/core/viewmodels/home/settings_view_model.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<SettingsViewModel>(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: FlatButton(
            onPressed: () => model.logout(),
            child: Text('LOG OUT'),
          ),
        ),
      ),
    );
  }
}
