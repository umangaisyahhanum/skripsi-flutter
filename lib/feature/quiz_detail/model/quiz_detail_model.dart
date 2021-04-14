class QuizDetailModel {
  String createdAt;
  String provinsi;
  String distance;
  String deskripsi;
  String status;
  String id;
  String latitude;
  String quizDetail;
  String createdBy;
  String value;
  String project;
  String kota;
  int btnAbsen;
  String option;
  String toleransiJarak;
  String longitude;
  String updatedAt;

  QuizDetailModel({
    this.createdAt,
    this.provinsi,
    this.distance,
    this.deskripsi,
    this.status,
    this.id,
    this.latitude,
    this.quizDetail,
    this.createdBy,
    this.value,
    this.project,
    this.kota,
    this.btnAbsen,
    this.option,
    this.toleransiJarak,
    this.longitude,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      "created_at": this.createdAt,
      "provinsi": this.provinsi,
      "distance": this.distance,
      "deskripsi": this.deskripsi,
      "status": this.status,
      "id": this.id,
      "latitude": this.latitude,
      "quizDetail": this.quizDetail,
      "created_by": this.createdBy,
      "value": this.value,
      "project": this.project,
      "kota": this.kota,
      "btn_absen": this.btnAbsen,
      "option": this.option,
      "toleransi_jarak": this.toleransiJarak,
      "longitude": this.longitude,
      "updated_at": this.updatedAt,
    };
  }

  factory QuizDetailModel.fromJson(Map<String, dynamic> data) {
    QuizDetailModel quizDetailModel = QuizDetailModel(
      createdAt: data['created_at'],
      provinsi: data['provinsi'],
      distance: data['distance'],
      deskripsi: data['deskripsi'],
      status: data['status'],
      id: data['id'],
      latitude: data['latitude'],
      quizDetail: data['quizDetail'],
      createdBy: data['created_by'],
      value: data['value'],
      project: data['project'],
      kota: data['kota'],
      btnAbsen: data['btn_absen'],
      option: data['option'],
      toleransiJarak: data['toleransi_jarak'],
      longitude: data['longitude'],
      updatedAt: data['updated_at'],
    );
    return quizDetailModel;
  }
}

