import "userByParam_model.dart";

class DataModel {
  UserByParamModel userByParam;

  DataModel({
    this.userByParam,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> userByParamTmp = this.userByParam.toJson();

    return {
      "userByParam": userByParamTmp,
    };
  }

  factory DataModel.fromJson(Map<String, dynamic> data) {
    UserByParamModel userByParamTmp = UserByParamModel.fromJson(data["userByParam"]);

    DataModel dataModel = DataModel(
      userByParam: userByParamTmp,
    );
    return dataModel;
  }
}
