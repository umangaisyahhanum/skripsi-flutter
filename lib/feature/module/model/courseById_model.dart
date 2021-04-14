import "bab_model.dart";

class CourseByIdModel{
	List<BabModel> bab;
	String id;
	String type;
	String title;

	CourseByIdModel({
		this.bab,
		this.id,
		this.type,
		this.title,
	});

	Map<String,dynamic> toJson(){
		List<Map<String, dynamic>> babList = this.bab.map((i) => i.toJson()).toList();

		return {
			"bab" : babList,
			"_id" : this.id,
			"type" : this.type,
			"title" : this.title,
		};
	}

	factory CourseByIdModel.fromJson(Map<String, dynamic> data){
		var babList = data["bab"] as List;
List<BabModel> babTmp = babList.map((i) => BabModel.fromJson(i)).toList();

		CourseByIdModel courseByIdModel = CourseByIdModel(
			bab : babTmp,
			id : data['_id'],
			type : data['type'],
			title : data['title'],
		);
		return courseByIdModel;
	}
}
