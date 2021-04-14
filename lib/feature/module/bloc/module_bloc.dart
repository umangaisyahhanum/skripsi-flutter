import 'dart:async';

import '../repository/module_repository.dart';
import 'module_state.dart';
import 'package:meta/meta.dart';

class ModuleBloc {
  final ModuleRepository moduleRepository;

  ModuleBloc({@required ModuleRepository moduleRepository})
      : assert(moduleRepository != null),
        this.moduleRepository = moduleRepository;

  StreamController<ModuleState> _moduleController = StreamController<ModuleState>.broadcast();
  Stream<ModuleState> get moduleState => _moduleController.stream.asBroadcastStream();

  ModuleState get initialState => ModuleLoading();

  // StreamController<AddModuleState> _addmoduleController = StreamController<AddModuleState>.broadcast();
  // Stream<AddModuleState> get addmoduleState => _addmoduleController.stream.asBroadcastStream();

  // AddModuleState get addInitialState => AddModuleLoading();

  void dispose() {
    _moduleController.close();
    // _addmoduleController.close();
  }

  void getModule(String course_id) {
    _moduleController.add(ModuleLoading());
    moduleRepository.requestModule(course_id).then((value) {
      _moduleController.add(value);
    });
  }

  // void addModule(String id_user, String id_project) {
  //   _addmoduleController.add(AddModuleLoading());
  //   moduleRepository.addModule(id_project).then((value) {
  //     _addmoduleController.add(value);
  //   });
  // }
}
