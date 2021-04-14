import '../model/register_model.dart';
import 'package:meta/meta.dart';

abstract class RegisterState {}

class RegisterEmpty extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterEmailIsRegistered extends RegisterState {}

class RegisterLoaded extends RegisterState {}

class RegisterError extends RegisterState {
  final String message;

  RegisterError({@required this.message});
}
