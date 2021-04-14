import 'package:meta/meta.dart';
import '../../class/model/enrollment_model.dart';

abstract class ClassState {}

class ClassEmpty extends ClassState {}

class ClassLoading extends ClassState {}

class ClassLoaded extends ClassState {
  final List<EnrollmentModel> classList;

  ClassLoaded({@required this.classList});
}

class ClassError extends ClassState {
  final String message;

  ClassError({@required this.message});
}
