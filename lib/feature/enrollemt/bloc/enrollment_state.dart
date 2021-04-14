import 'package:simplilearn/feature/enrollemt/model/enrollment_model.dart';
import 'package:meta/meta.dart';

abstract class EnrollmentState {}

class EnrollmentEmpty extends EnrollmentState {}

class EnrollmentLoading extends EnrollmentState {}

class EnrollmentLoaded extends EnrollmentState {
  final List<EnrollmentModel> enrollmentList;

  EnrollmentLoaded({@required this.enrollmentList});
}

class EnrollmentError extends EnrollmentState {
  final String message;

  EnrollmentError({@required this.message});
}
