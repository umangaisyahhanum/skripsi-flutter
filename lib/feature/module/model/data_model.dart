import "courseById_model.dart";

class DataModel{
	CourseByIdModel courseById;

	DataModel({
		this.courseById,
	});

	Map<String,dynamic> toJson(){
		Map<String, dynamic> courseByIdTmp = this.courseById.toJson();

		return {
			"courseById" : courseByIdTmp,
		};
	}

	factory DataModel.fromJson(Map<String, dynamic> data){
		CourseByIdModel courseByIdTmp = CourseByIdModel.fromJson(data["courseById"]);

		DataModel dataModel = DataModel(
			courseById : courseByIdTmp,
		);
		return dataModel;
	}
}
