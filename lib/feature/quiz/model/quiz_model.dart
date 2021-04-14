import "question_model.dart";

class QuizModel{
	String id;
	String order;
	String title;
	List<QuestionModel> question;

	QuizModel({
		this.id,
		this.order,
		this.title,
		this.question,
	});

	Map<String,dynamic> toJson(){
		List<Map<String, dynamic>> questionList = this.question.map((i) => i.toJson()).toList();

		return {
			"_id" : this.id,
			"order" : this.order,
			"title" : this.title,
			"question" : questionList,
		};
	}

	factory QuizModel.fromJson(Map<String, dynamic> data){
		var questionList = data["question"] as List;
List<QuestionModel> questionTmp = questionList.map((i) => QuestionModel.fromJson(i)).toList();

		QuizModel quizModel = QuizModel(
			id : data['_id'],
			order : data['order'],
			title : data['title'],
			question : questionTmp,
		);
		return quizModel;
	}
}
