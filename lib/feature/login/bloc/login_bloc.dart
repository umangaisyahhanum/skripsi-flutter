import 'dart:async';

import '../repository/login_repository.dart';
import 'login_state.dart';
import 'package:meta/meta.dart';

class LoginBloc {
  final LoginRepository loginRepository;

  LoginBloc({@required LoginRepository loginRepository})
      : assert(loginRepository != null),
        this.loginRepository = loginRepository;

  StreamController<LoginState> _loginController = StreamController<LoginState>.broadcast();
  Stream<LoginState> get loginState => _loginController.stream.asBroadcastStream();

  LoginState get initialState => LoginEmpty();

  void dispose() {
    _loginController.close();
  }

  void getLogin(String id_user, String password) {
    _loginController.add(LoginLoading());
    loginRepository.requestLogin(id_user, password).then((value) {
      _loginController.add(value);
    });
  }
}
