import 'dart:async';

import '../repository/class_repository.dart';
import 'class_state.dart';
import 'package:meta/meta.dart';

class ClassBloc {
  final ClassRepository classRepository;

  ClassBloc({@required ClassRepository classRepository})
      : assert(classRepository != null),
        this.classRepository = classRepository;

  StreamController<ClassState> _classController = StreamController<ClassState>.broadcast();
  Stream<ClassState> get classState => _classController.stream.asBroadcastStream();

  ClassState get initialState => ClassLoading();

  void dispose() {
    _classController.close();
  }

  void getClass() {
    _classController.add(ClassLoading());
    classRepository.requestClass().then((value) {
      _classController.add(value);
    });
  }
}
