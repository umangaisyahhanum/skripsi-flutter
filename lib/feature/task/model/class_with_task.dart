import 'task_model.dart';

class ClassWithTask {
  List<TaskModel> task;
  String id;
  String name;

  ClassWithTask({
    this.task,
    this.id,
    this.name,
  });

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> taskList = this.task.map((i) => i.toJson()).toList();

    return {
      "task": taskList,
      "_id": this.id,
      "name": this.name,
    };
  }

  factory ClassWithTask.fromJson(Map<String, dynamic> data) {
    var taskList = data["task"] as List;
    List<TaskModel> taskTmp = taskList.map((i) => TaskModel.fromJson(i)).toList();

    ClassWithTask classByIdModel = ClassWithTask(
      task: taskTmp,
      id: data['_id'],
      name: data['name'],
    );
    return classByIdModel;
  }
}
