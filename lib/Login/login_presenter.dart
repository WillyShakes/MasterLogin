import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class LoginViewContract {
  void onLoginScuccess(String msg);
  void onLoginError(String message);
}

class LoginPresenter {
  LoginViewContract _view;
  LoginPresenter(this._view);
  static const platform = const MethodChannel('masterlogin/login');

  void perform_login() {
    assert(_view != null);
    try {
      platform.invokeMethod('login').then((result) {
        if(result != "false") {
          _view.onLoginScuccess('Congratulations, you are in. ' + result);
        }
        else
          _view.onLoginError('Error');
      });

    } on PlatformException catch (e) {
      _view.onLoginError("Failed to login: '${e.message}'.");
    }
  }
}