import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pals_hand/core/enums/viewstate.dart';
import 'package:pals_hand/core/models/user.dart';
import 'package:pals_hand/core/services/authentication_service.dart';
import 'package:pals_hand/core/services/database_service.dart';

import '../../../locator.dart';
import '../base_model.dart';

class FriendsListViewModel extends BaseModel {
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  bool _ready = false;
  bool _start = true;

  bool get ready => _ready;
  bool get start => _start;

  Future<bool> isReady() async {
    FirebaseUser authUser = await _authenticationService.user.currentUser();
    return await DatabaseService(uid: authUser.uid).getReady();
  }

  Future<List<Map<dynamic, dynamic>>> getUsers() async {
    List<Map<dynamic, dynamic>> userList = List<Map<dynamic, dynamic>>();
    try {
      FirebaseUser authUser = await _authenticationService.user.currentUser();

      _ready = await DatabaseService(uid: authUser.uid).getReady();

      QuerySnapshot snapshot =
          await DatabaseService(uid: authUser.uid).getUsers();

      List<User> users =
          snapshot.documents.map((user) => User.fromJson(user.data)).toList();

      users.removeWhere((user) => user.uid == authUser.uid);

      userList = users
          .map((user) =>
              {'user': user, 'chosen': user.friendList == authUser.uid})
          .toList();
    } catch (error) {}
    return userList;
  }

  updateFriendListData(String frienduid) async {
    setState(ViewState.Busy);
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    await DatabaseService(uid: user.uid)
        .updateFriendListData(frienduid: frienduid);
    setState(ViewState.Idle);
  }
}
