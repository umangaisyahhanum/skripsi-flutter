

class TaskModel{
	String title;
	String description;
	String id;

	TaskModel({
		this.title,
		this.description,
		this.id,
	});

	Map<String,dynamic> toJson(){
		

		return {
			"title" : this.title,
			"description" : this.description,
			"_id" : this.id,
		};
	}

	factory TaskModel.fromJson(Map<String, dynamic> data){
		

		TaskModel taskModel = TaskModel(
			title : data['title'],
			description : data['description'],
			id : data['_id'],
		);
		return taskModel;
	}
}
