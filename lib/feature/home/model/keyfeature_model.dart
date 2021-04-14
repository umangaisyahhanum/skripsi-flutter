class KeyfeatureModel {
  String id;
  String title;

  KeyfeatureModel({
    this.id,
    this.title,
  });

  Map<String, dynamic> toJson() {
    return {
      "_id": this.id,
    };
  }

  factory KeyfeatureModel.fromJson(Map<String, dynamic> data) {
    KeyfeatureModel keyfeatureModel = KeyfeatureModel(
      id: data['_id'],
      title: data['title'],
    );
    return keyfeatureModel;
  }
}
