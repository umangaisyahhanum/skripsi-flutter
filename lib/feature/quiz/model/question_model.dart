

class QuestionModel{
	String d;
	String id;
	String order;
	String question;
	String answer;
	String a;
	String b;
	String c;

	QuestionModel({
		this.d,
		this.id,
		this.order,
		this.question,
		this.answer,
		this.a,
		this.b,
		this.c,
	});

	Map<String,dynamic> toJson(){
		

		return {
			"d" : this.d,
			"_id" : this.id,
			"order" : this.order,
			"question" : this.question,
			"answer" : this.answer,
			"a" : this.a,
			"b" : this.b,
			"c" : this.c,
		};
	}

	factory QuestionModel.fromJson(Map<String, dynamic> data){
		

		QuestionModel questionModel = QuestionModel(
			d : data['d'],
			id : data['_id'],
			order : data['order'],
			question : data['question'],
			answer : data['answer'],
			a : data['a'],
			b : data['b'],
			c : data['c'],
		);
		return questionModel;
	}
}
