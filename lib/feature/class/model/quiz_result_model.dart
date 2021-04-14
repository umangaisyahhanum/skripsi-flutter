class Quiz_resultModel {
  String score;
  String id;

  Quiz_resultModel({
    this.score,
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      "score": this.score,
      "_id": this.id,
    };
  }

  factory Quiz_resultModel.fromJson(Map<String, dynamic> data) {
    Quiz_resultModel quizResultModel = Quiz_resultModel(
      score: data['score'],
      id: data['_id'],
    );
    return quizResultModel;
  }
}
