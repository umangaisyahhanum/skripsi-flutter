import "bab_model.dart";
import "quiz_model.dart";

class CourseModel {
  String title;
  String description;
  List<BabModel> bab;
  List<QuizModel> quiz;
  String id;
  String type;

  CourseModel({
    this.title,
    this.description,
    this.bab,
    this.quiz,
    this.id,
    this.type,
  });

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> babList = this.bab.map((i) => i.toJson()).toList();
    List<Map<String, dynamic>> quizList = this.quiz.map((i) => i.toJson()).toList();

    return {
      "title": this.title,
      "description": this.description,
      "bab": babList,
      "quiz": quizList,
      "_id": this.id,
      "type": this.type,
    };
  }

  factory CourseModel.fromJson(Map<String, dynamic> data) {
    var babList = data["bab"] as List;
    List<BabModel> babTmp = babList.map((i) => BabModel.fromJson(i)).toList();
    var quizList = data["quiz"] as List;
    List<QuizModel> quizTmp = quizList.map((i) => QuizModel.fromJson(i)).toList();

    CourseModel courseModel = CourseModel(
      title: data['title'],
      description: data['description'],
      bab: babTmp,
      quiz: quizTmp,
      id: data['_id'],
      type: data['type'],
    );
    return courseModel;
  }
}
