import "enrollment_model.dart";

class UserByParamModel {
  List<EnrollmentModel> enrollment;

  UserByParamModel({
    this.enrollment,
  });

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> enrollmentList = this.enrollment.map((i) => i.toJson()).toList();

    return {
      "enrollment": enrollmentList,
    };
  }

  factory UserByParamModel.fromJson(Map<String, dynamic> data) {
    var enrollmentList = data["enrollment"] as List;
    List<EnrollmentModel> enrollmentTmp = enrollmentList.map((i) => EnrollmentModel.fromJson(i)).toList();

    UserByParamModel userByParamModel = UserByParamModel(
      enrollment: enrollmentTmp,
    );
    return userByParamModel;
  }
}
