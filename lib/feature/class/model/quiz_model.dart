class QuizModel {
  String id;

  QuizModel({
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      "_id": this.id,
    };
  }

  factory QuizModel.fromJson(Map<String, dynamic> data) {
    QuizModel quizModel = QuizModel(
      id: data['_id'],
    );
    return quizModel;
  }
}
