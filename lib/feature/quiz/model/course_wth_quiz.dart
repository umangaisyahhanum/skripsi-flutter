import 'quiz_model.dart';

class CourseWithQuiz {
  String title;
  List<QuizModel> quiz;
  String id;

  CourseWithQuiz({
    this.title,
    this.quiz,
    this.id,
  });

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> quizList = this.quiz.map((i) => i.toJson()).toList();

    return {
      "title": this.title,
      "quiz": quizList,
      "_id": this.id,
    };
  }

  factory CourseWithQuiz.fromJson(Map<String, dynamic> data) {
    var quizList = data["quiz"] as List;
    List<QuizModel> quizTmp = quizList.map((i) => QuizModel.fromJson(i)).toList();

    CourseWithQuiz courseByIdModel = CourseWithQuiz(
      title: data['title'],
      quiz: quizTmp,
      id: data['_id'],
    );
    return courseByIdModel;
  }
}
