import "instructor_model.dart";
import "task_model.dart";

class ClassModel {
  String name;
  List<InstructorModel> instructor;
  List<TaskModel> task;
  String id;

  ClassModel({
    this.name,
    this.instructor,
    this.task,
    this.id,
  });

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> instructorList = this.instructor.map((i) => i.toJson()).toList();
    List<Map<String, dynamic>> taskList = this.task.map((i) => i.toJson()).toList();

    return {
      "name": this.name,
      "instructor": instructorList,
      "task": taskList,
      "_id": this.id,
    };
  }

  factory ClassModel.fromJson(Map<String, dynamic> data) {
    var instructorList = data["instructor"] as List;
    List<InstructorModel> instructorTmp = instructorList.map((i) => InstructorModel.fromJson(i)).toList();
    var taskList = data["task"] as List;
    List<TaskModel> taskTmp = taskList.map((i) => TaskModel.fromJson(i)).toList();

    ClassModel classModel = ClassModel(
      name: data['name'],
      instructor: instructorTmp,
      task: taskTmp,
      id: data['_id'],
    );
    return classModel;
  }
}
