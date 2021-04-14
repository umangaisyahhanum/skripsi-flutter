class MateriModel {
  String id;

  MateriModel({
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      "_id": this.id,
    };
  }

  factory MateriModel.fromJson(Map<String, dynamic> data) {
    MateriModel materiModel = MateriModel(
      id: data['_id'],
    );
    return materiModel;
  }
}
