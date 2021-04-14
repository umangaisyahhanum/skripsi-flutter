class MateriDetailModel {
  String createdAt;
  String provinsi;
  String distance;
  String deskripsi;
  String status;
  String id;
  String latitude;
  String materiDetail;
  String createdBy;
  String value;
  String project;
  String kota;
  int btnAbsen;
  String option;
  String toleransiJarak;
  String longitude;
  String updatedAt;

  MateriDetailModel({
    this.createdAt,
    this.provinsi,
    this.distance,
    this.deskripsi,
    this.status,
    this.id,
    this.latitude,
    this.materiDetail,
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
      "materiDetail": this.materiDetail,
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

  factory MateriDetailModel.fromJson(Map<String, dynamic> data) {
    MateriDetailModel materiDetailModel = MateriDetailModel(
      createdAt: data['created_at'],
      provinsi: data['provinsi'],
      distance: data['distance'],
      deskripsi: data['deskripsi'],
      status: data['status'],
      id: data['id'],
      latitude: data['latitude'],
      materiDetail: data['materiDetail'],
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
    return materiDetailModel;
  }
}

