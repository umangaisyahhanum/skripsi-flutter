import 'package:meta/meta.dart';
import 'package:simplilearn/feature/module/model/courseById_model.dart';

abstract class ModuleState {}

class ModuleEmpty extends ModuleState {}

class ModuleLoading extends ModuleState {}

class ModuleLoaded extends ModuleState {
  final CourseByIdModel moduleList;

  ModuleLoaded({@required this.moduleList});
}

class ModuleError extends ModuleState {
  final String message;

  ModuleError({@required this.message});
}

abstract class AddModuleState {}

class AddModuleEmpty extends AddModuleState {}

class AddModuleLoading extends AddModuleState {}

class AddModuleSuccess extends AddModuleState {
  final String message;

  AddModuleSuccess({@required this.message});
}

class AddModuleError extends AddModuleState {
  final String message;

  AddModuleError({@required this.message});
}
