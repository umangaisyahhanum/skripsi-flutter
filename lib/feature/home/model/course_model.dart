import 'learningpath_model.dart';
import 'keyfeature_model.dart';

class CourseModel {
  List<LearningpathModel> learningpath;
  List<KeyfeatureModel> keyfeature;
  String id;
  String type;
  String title;
  String description;

  CourseModel({
    this.learningpath,
    this.keyfeature,
    this.id,
    this.type,
    this.title,
    this.description,
  });

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> learningpathList = this.learningpath.map((i) => i.toJson()).toList();
    List<Map<String, dynamic>> keyfeatureList = this.keyfeature.map((i) => i.toJson()).toList();

    return {
      "learningpath": learningpathList,
      "keyfeature": keyfeatureList,
      "_id": this.id,
      "type": this.type,
      "title": this.title,
      "description": this.description,
    };
  }

  factory CourseModel.fromJson(Map<String, dynamic> data) {
    var learningpathList = data["learningpath"] as List;
    List<LearningpathModel> learningpathTmp = learningpathList.map((i) => LearningpathModel.fromJson(i)).toList();
    var keyfeatureList = data["keyfeature"] as List;
    List<KeyfeatureModel> keyfeatureTmp = keyfeatureList.map((i) => KeyfeatureModel.fromJson(i)).toList();

    CourseModel allCourseModel = CourseModel(
      learningpath: learningpathTmp,
      keyfeature: keyfeatureTmp,
      id: data['_id'],
      type: data['type'],
      title: data['title'],
      description: data['description'],
    );
    return allCourseModel;
  }
}
