import 'package:flutter/services.dart';
import 'package:masterlogin/Utils/auth0.dart' as auth0;
import 'package:masterlogin/Utils/constants.dart';

abstract class LoginViewContract {
  void onLoginScuccess();
  void onLoginError(String message);
}

class LoginPresenter {
  LoginViewContract _view;
  LoginPresenter(this._view);

  void perform_login() {
    assert(_view != null);
    auth0.getToken(constants.APP_DOMAIN,constants.APP_ID,constants.APP_SECRET).then((res)
    {
      print("res: "+res);
      if (res == "success") {
        _view.onLoginScuccess();
      }
      else {
        _view.onLoginError("Failed to login: $res");
      }
    });
  }
}