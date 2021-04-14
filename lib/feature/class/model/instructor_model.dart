class InstructorModel {
  String id;
  String name;
  String email;

  InstructorModel({
    this.id,
    this.name,
    this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      "_id": this.id,
      "name": this.name,
      "email": this.email,
    };
  }

  factory InstructorModel.fromJson(Map<String, dynamic> data) {
    InstructorModel instructorModel = InstructorModel(
      id: data['_id'],
      name: data['name'],
      email: data['email'],
    );
    return instructorModel;
  }
}
