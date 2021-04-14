import 'dart:async';

import '../repository/register_repository.dart';
import 'register_state.dart';
import 'package:meta/meta.dart';

class RegisterBloc {
  final RegisterRepository registerRepository;

  RegisterBloc({@required RegisterRepository registerRepository})
      : assert(registerRepository != null),
        this.registerRepository = registerRepository;

  StreamController<RegisterState> _registerController = StreamController<RegisterState>.broadcast();
  Stream<RegisterState> get registerState => _registerController.stream.asBroadcastStream();

  RegisterState get initialState => RegisterEmpty();

  void dispose() {
    _registerController.close();
  }

  void getRegister(String email, String password, String name, String phonenumber) {
    _registerController.add(RegisterLoading());
    registerRepository.checkEmail(email, password, name, phonenumber).then((value) {
      _registerController.add(value);
    });
  }
}
