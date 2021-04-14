import 'dart:async';

import '../repository/task_repository.dart';
import 'task_state.dart';
import 'package:meta/meta.dart';

class TaskBloc {
  final TaskRepository taskRepository;

  TaskBloc({@required TaskRepository taskRepository})
      : assert(taskRepository != null),
        this.taskRepository = taskRepository;

  StreamController<TaskState> _taskController = StreamController<TaskState>.broadcast();
  Stream<TaskState> get taskState => _taskController.stream.asBroadcastStream();

  TaskState get initialState => TaskLoading();

  StreamController<AddTaskState> _addtaskController = StreamController<AddTaskState>.broadcast();
  Stream<AddTaskState> get addtaskState => _addtaskController.stream.asBroadcastStream();

  AddTaskState get addInitialState => AddTaskLoading();

  void dispose() {
    _taskController.close();
    _addtaskController.close();
  }

  void getTask(String id_project) {
    _taskController.add(TaskLoading());
    taskRepository.requestTask(id_project).then((value) {
      _taskController.add(value);
    });
  }

  void addTask(String id_user, String id_project) {
    _addtaskController.add(AddTaskLoading());
    taskRepository.addTask(id_project).then((value) {
      _addtaskController.add(value);
    });
  }
}

