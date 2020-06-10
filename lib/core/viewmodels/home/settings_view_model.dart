import 'package:pals_hand/core/services/authentication_service.dart';

import '../../../locator.dart';
import '../base_model.dart';

class SettingsViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  
  Future logout() async {
    await _authenticationService.logout();
  }
}
