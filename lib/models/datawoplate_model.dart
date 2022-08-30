List<DataWOPlateModel> datasFromJson(dynamic str) =>
    List<DataWOPlateModel>.from((str).map((x) => DataWOPlateModel.fromJson(x)));

class DataWOPlateModel {
  late String? id;
  late String? firstName;
  late String? lastName;
  late String? studentId;
  late String? faculty;
  late String? charge;
  late String? uploadedImageCard;
  late String? uploadedImageEvent;
  late String? uploadedImageCardUUID;
  late String? uploadedImageEventUUID;

  DataWOPlateModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.studentId,
      this.faculty,
      this.charge,
      this.uploadedImageCard,
      this.uploadedImageEvent,
      this.uploadedImageCardUUID,
      this.uploadedImageEventUUID});

  DataWOPlateModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    firstName = json["first_name"];
    lastName = json["last_name"];
    studentId = json["student_id"];
    faculty = json["faculty"];
    charge = json["charge"];
    uploadedImageCard = json["uploadedImageCard"];
    uploadedImageEvent = json["uploadedImageEvent"];
    uploadedImageCardUUID = json["uploadedImageCardUUID"];
    uploadedImageEventUUID = json["uploadedImageEventUUID"];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["first_name"] = firstName;
    _data["last_name"] = lastName;
    _data["student_id"] = studentId;
    _data["faculty"] = faculty;
    _data["charge"] = charge;
    _data["uploadedImageCard"] = uploadedImageCard;
    _data["uploadedImageEvent"] = uploadedImageEvent;
    _data["uploadedImageCardUUID"] = uploadedImageCardUUID;
    _data["uploadedImageEventUUID"] = uploadedImageEventUUID;

    return _data;
  }
}
