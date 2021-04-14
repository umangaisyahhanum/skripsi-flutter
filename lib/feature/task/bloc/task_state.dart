import 'package:simplilearn/feature/task/model/class_with_task.dart';

import '../model/task_model.dart';
import 'package:meta/meta.dart';

abstract class TaskState {}

class TaskEmpty extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final ClassWithTask classWithTask;

  TaskLoaded({@required this.classWithTask});
}

class TaskError extends TaskState {
  final String message;

  TaskError({@required this.message});
}

abstract class AddTaskState {}

class AddTaskEmpty extends AddTaskState {}

class AddTaskLoading extends AddTaskState {}

class AddTaskSuccess extends AddTaskState {
  final String message;

  AddTaskSuccess({@required this.message});
}

class AddTaskError extends AddTaskState {
  final String message;

  AddTaskError({@required this.message});
}
