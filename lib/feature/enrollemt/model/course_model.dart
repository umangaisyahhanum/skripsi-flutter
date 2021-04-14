

class CourseModel{
	String id;
	String title;
	String type;

	CourseModel({
		this.id,
		this.title,
		this.type,
	});

	Map<String,dynamic> toJson(){
		

		return {
			"_id" : this.id,
			"title" : this.title,
			"type" : this.type,
		};
	}

	factory CourseModel.fromJson(Map<String, dynamic> data){
		

		CourseModel courseModel = CourseModel(
			id : data['_id'],
			title : data['title'],
			type : data['type'],
		);
		return courseModel;
	}
}
