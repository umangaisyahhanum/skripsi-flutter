import '../model/login_model.dart';
import 'package:meta/meta.dart';

abstract class LoginState {}

class LoginEmpty extends LoginState {}

class LoginLoading extends LoginState {}

class LoginWrongPassword extends LoginState {}

class LoginEmailNotRegistered extends LoginState {}

class LoginLoaded extends LoginState {}

class LoginError extends LoginState {
  final String message;

  LoginError({@required this.message});
}
