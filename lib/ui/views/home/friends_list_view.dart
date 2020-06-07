import 'package:flutter/material.dart';
import 'package:pals_hand/core/viewmodels/base_view.dart';
import 'package:pals_hand/core/viewmodels/home/friends_list_view_model.dart';

class FriendListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<FriendsListViewModel>(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text('Friends List'),
        ),
      ),
    );
  }
}
