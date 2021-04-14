import "task_result_model.dart";
import "quiz_result_model.dart";
import "course_model.dart";
import "class_model.dart";

class EnrollmentModel {
  String materiResult;
  List<Task_resultModel> taskResult;
  List<Quiz_resultModel> quizResult;
  List<CourseModel> course;
  List<ClassModel> studentClass;
  String id;
  String status;

  EnrollmentModel({
    this.materiResult,
    this.taskResult,
    this.quizResult,
    this.course,
    this.studentClass,
    this.id,
    this.status,
  });

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> task_resultList = this.taskResult.map((i) => i.toJson()).toList();
    List<Map<String, dynamic>> quiz_resultList = this.quizResult.map((i) => i.toJson()).toList();
    List<Map<String, dynamic>> courseList = this.course.map((i) => i.toJson()).toList();
    List<Map<String, dynamic>> classList = this.studentClass.map((i) => i.toJson()).toList();

    return {
      "materi_result": this.materiResult,
      "task_result": task_resultList,
      "quiz_result": quiz_resultList,
      "course": courseList,
      "class": classList,
      "_id": this.id,
      "status": this.status,
    };
  }

  factory EnrollmentModel.fromJson(Map<String, dynamic> data) {
    var task_resultList = data["task"] as List;
    List<Task_resultModel> task_resultTmp = task_resultList.map((i) => Task_resultModel.fromJson(i)).toList();
    var quiz_resultList = data["quiz"] as List;
    List<Quiz_resultModel> quiz_resultTmp = quiz_resultList.map((i) => Quiz_resultModel.fromJson(i)).toList();
    var courseList = data["course"] as List;
    List<CourseModel> courseTmp = courseList.map((i) => CourseModel.fromJson(i)).toList();
    var classList = data["class"] as List;
    List<ClassModel> classTmp = classList.map((i) => ClassModel.fromJson(i)).toList();

    EnrollmentModel enrollmentModel = EnrollmentModel(
      materiResult: data['materi'],
      taskResult: task_resultTmp,
      quizResult: quiz_resultTmp,
      course: courseTmp,
      studentClass: classTmp,
      id: data['_id'],
      status: data['status'],
    );
    return enrollmentModel;
  }
}
