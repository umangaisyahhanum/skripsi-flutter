import "data_model.dart";

class ResponseModel {
  DataModel data;

  ResponseModel({
    this.data,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> dataTmp = this.data.toJson();

    return {
      "data": dataTmp,
    };
  }

  factory ResponseModel.fromJson(Map<String, dynamic> data) {
    DataModel dataTmp = DataModel.fromJson(data["data"]);

    ResponseModel responseModel = ResponseModel(
      data: dataTmp,
    );
    return responseModel;
  }
}
