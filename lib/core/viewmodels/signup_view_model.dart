import 'package:pals_hand/core/enums/viewstate.dart';
import 'package:pals_hand/locator.dart';
import 'package:pals_hand/core/services/authentication_service.dart';
import 'package:pals_hand/core/services/dialog_service.dart';
import 'package:pals_hand/core/services/navigation_service.dart';
import 'package:flutter/foundation.dart';

import 'base_model.dart';

class SignupViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future signUp({
    @required String name,
    @required String email,
    @required String password,
  }) async {
    _isLoading = true;

    setState(ViewState.Idle);

    var result = await _authenticationService.signupWithEmail(
      name: name,
      email: email,
      password: password,
    );

    if (result is bool) {
      if (result) {
        _isLoading = false;
        _navigationService.pop();
      } else {
        await _dialogService.showDialog(
          title: 'Fallo en el Registro',
          description: 'Fallo general de registro. Vuelva a intentarlo mas tarde',
        );

        _isLoading = false;

        setState(ViewState.Idle);
      }
    } else {
      await _dialogService.showDialog(
        title: 'Fallo en el Registro',
        description: result,
      );
      _isLoading = false;

      setState(ViewState.Idle);
    }
  }
}
