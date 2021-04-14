import "materi_model.dart";

class BabModel {
  List<MateriModel> materi;

  BabModel({
    this.materi,
  });

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> materiList = this.materi.map((i) => i.toJson()).toList();

    return {
      "materi": materiList,
    };
  }

  factory BabModel.fromJson(Map<String, dynamic> data) {
    var materiList = data["materi"] as List;
    List<MateriModel> materiTmp = materiList.map((i) => MateriModel.fromJson(i)).toList();

    BabModel babModel = BabModel(
      materi: materiTmp,
    );
    return babModel;
  }
}
