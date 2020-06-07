import 'package:flutter/foundation.dart';
import 'package:pals_hand/core/enums/viewstate.dart';
import 'package:pals_hand/core/services/authentication_service.dart';
import 'package:pals_hand/core/services/dialog_service.dart';
import 'package:pals_hand/core/services/navigation_service.dart';
import 'base_model.dart';
import '../../locator.dart';

class LoginViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  String errorMessage;

  Future login({@required String email, @required String password}) async {

    var result = await _authenticationService.loginWithEmail(
        email: email, password: password);

    if (result is bool) {
      if (result) {
        //_navigationService.navigateTo('/home');
      } else {
        await _dialogService.showDialog(
          title: 'Login Failure',
          description: 'Couldn\'t login at this moment. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Login Failure',
        description: result,
      );
    }
  }

  Future loginWithGoogle({@required String email, @required String password}) async {

    var result = await _authenticationService.loginWithGoogle(
        email: email, password: password);

    if (result is bool) {
      if (result) {
        // _navigationService.navigateTo('/home');
      } else {
        await _dialogService.showDialog(
          title: 'Login Failure',
          description: 'Couldn\'t login at this moment. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Login Failure',
        description: result,
      );
    }
  }
}
