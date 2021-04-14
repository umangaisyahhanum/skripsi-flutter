class TaskModel {
  String id;

  TaskModel({
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      "_id": this.id,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> data) {
    TaskModel taskModel = TaskModel(
      id: data['_id'],
    );
    return taskModel;
  }
}
