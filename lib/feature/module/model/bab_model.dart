import "materi_model.dart";

class BabModel{
	String id;
	String name;
	String order;
	List<MateriModel> materi;

	BabModel({
		this.id,
		this.name,
		this.order,
		this.materi,
	});

	Map<String,dynamic> toJson(){
		List<Map<String, dynamic>> materiList = this.materi.map((i) => i.toJson()).toList();

		return {
			"_id" : this.id,
			"name" : this.name,
			"order" : this.order,
			"materi" : materiList,
		};
	}

	factory BabModel.fromJson(Map<String, dynamic> data){
		var materiList = data["materi"] as List;
List<MateriModel> materiTmp = materiList.map((i) => MateriModel.fromJson(i)).toList();

		BabModel babModel = BabModel(
			id : data['_id'],
			name : data['name'],
			order : data['order'],
			materi : materiTmp,
		);
		return babModel;
	}
}
