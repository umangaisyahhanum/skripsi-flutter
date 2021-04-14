class LearningpathModel {
  String title;
  String description;
  String id;

  LearningpathModel({
    this.title,
    this.description,
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": this.title,
      "description": this.description,
      "_id": this.id,
    };
  }

  factory LearningpathModel.fromJson(Map<String, dynamic> data) {
    LearningpathModel learningpathModel = LearningpathModel(
      title: data['title'],
      description: data['description'],
      id: data['_id'],
    );
    return learningpathModel;
  }
}
