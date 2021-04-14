class Task_resultModel {
  String id;

  Task_resultModel({
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      "_id": this.id,
    };
  }

  factory Task_resultModel.fromJson(Map<String, dynamic> data) {
    Task_resultModel taskResultModel = Task_resultModel(
      id: data['_id'],
    );
    return taskResultModel;
  }
}
