import 'package:firebase_auth/firebase_auth.dart';
import 'package:pals_hand/core/models/user.dart';
import 'package:pals_hand/core/services/authentication_service.dart';
import 'package:pals_hand/core/services/database_service.dart';

import '../../../locator.dart';
import '../base_model.dart';

class SettingsViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future<User> getUser() async {
    FirebaseUser authUser = await FirebaseAuth.instance.currentUser();
    
    return User.fromJson(
        (await DatabaseService(uid: authUser.uid).getUser()).data);
  }

  Future logout() async {
    await _authenticationService.logout();
  }
}
