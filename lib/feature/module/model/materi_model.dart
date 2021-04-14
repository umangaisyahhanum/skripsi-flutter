

class MateriModel{
	String id;
	String name;
	String content;
	String order;

	MateriModel({
		this.id,
		this.name,
		this.content,
		this.order,
	});

	Map<String,dynamic> toJson(){
		

		return {
			"_id" : this.id,
			"name" : this.name,
			"content" : this.content,
			"order" : this.order,
		};
	}

	factory MateriModel.fromJson(Map<String, dynamic> data){
		

		MateriModel materiModel = MateriModel(
			id : data['_id'],
			name : data['name'],
			content : data['content'],
			order : data['order'],
		);
		return materiModel;
	}
}
