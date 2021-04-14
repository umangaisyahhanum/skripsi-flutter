import "course_model.dart";

class EnrollmentModel{
	String id;
	String status;
	List<CourseModel> course;

	EnrollmentModel({
		this.id,
		this.status,
		this.course,
	});

	Map<String,dynamic> toJson(){
		List<Map<String, dynamic>> courseList = this.course.map((i) => i.toJson()).toList();

		return {
			"_id" : this.id,
			"status" : this.status,
			"course" : courseList,
		};
	}

	factory EnrollmentModel.fromJson(Map<String, dynamic> data){
		var courseList = data["course"] as List;
List<CourseModel> courseTmp = courseList.map((i) => CourseModel.fromJson(i)).toList();

		EnrollmentModel enrollmentModel = EnrollmentModel(
			id : data['_id'],
			status : data['status'],
			course : courseTmp,
		);
		return enrollmentModel;
	}
}
