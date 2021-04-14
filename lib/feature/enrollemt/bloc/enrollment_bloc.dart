import 'dart:async';

import '../repository/enrollment_repository.dart';
import 'enrollment_state.dart';
import 'package:meta/meta.dart';

class EnrollmentBloc {
  final EnrollmentRepository enrollmentRepository;

  EnrollmentBloc({@required EnrollmentRepository enrollmentRepository})
      : assert(enrollmentRepository != null),
        this.enrollmentRepository = enrollmentRepository;

  StreamController<EnrollmentState> _enrollmentController = StreamController<EnrollmentState>.broadcast();
  Stream<EnrollmentState> get enrollmentState => _enrollmentController.stream.asBroadcastStream();

  EnrollmentState get initialState => EnrollmentLoading();

  void dispose() {
    _enrollmentController.close();
  }

  void getEnrollment() {
    _enrollmentController.add(EnrollmentLoading());
    enrollmentRepository.requestEnrollment().then((value) {
      _enrollmentController.add(value);
    });
  }
}
