import 'package:flutter/foundation.dart';
import 'package:pals_hand/core/enums/viewstate.dart';
import 'package:pals_hand/core/services/authentication_service.dart';
import 'package:pals_hand/core/services/dialog_service.dart';
import 'base_model.dart';
import '../../locator.dart';

class LoginViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();

  bool _isLoading = false;
  bool _isLoadingGoogle = false;
  String errorMessage;

  bool get isLoading => _isLoading;
  bool get isLoadingGoogle => _isLoadingGoogle;

  Future login({@required String email, @required String password}) async {
    _isLoading = true;

    setState(ViewState.Idle);

    var result = await _authenticationService.loginWithEmail(
        email: email, password: password);

    if (result is bool) {
      if (result) {
        _isLoading = false;
      } else {
        await _dialogService.showDialog(
          title: 'Login Failure',
          description: 'Couldn\'t login at this moment. Please try again later',
        );
        _isLoading = false;

        setState(ViewState.Idle);
      }
    } else {
      await _dialogService.showDialog(
        title: 'Login Failure',
        description: result,
      );
      _isLoading = false;

      setState(ViewState.Idle);
    }
  }

  Future loginWithGoogle(
      {@required String email, @required String password}) async {
    _isLoadingGoogle = true;

    setState(ViewState.Idle);

    var result = await _authenticationService.loginWithGoogle(
        email: email, password: password);

    if (result is bool) {
      if (result) {
        _isLoadingGoogle = false;
        // _navigationService.navigateTo('/home');
      } else {
        await _dialogService.showDialog(
          title: 'Fallo en el Inicio de Sesión',
          description: 'No se puede iniciar sesión actualmente. Vuelva a intentarlo mas tarde',
        );
        _isLoadingGoogle = false;

        setState(ViewState.Idle);
      }
    } else {
      await _dialogService.showDialog(
        title: 'Fallo en el Inicio de Sesión',
        description: result,
      );
      _isLoadingGoogle = false;

      setState(ViewState.Idle);
    }
  }
}
