List<StudentModel> datasFromJson(dynamic str) =>
    List<StudentModel>.from((str).map((x) => StudentModel.fromJson(x)));

class StudentModel {
  late String? id;
  late String? firstName;
  late String? lastName;
  late String? studentId;
  late String? faculty;
  late String? licensePartOne;
  late String? licensePartTwo;
  late String? licensePartThree;
  late String? image;
  late String? uploadedCardImages;

  StudentModel(
      {this.id,
        this.firstName,
        this.lastName,
        this.studentId,
        this.faculty,
        this.licensePartOne,
        this.licensePartTwo,
        this.licensePartThree,
        this.image,
        this.uploadedCardImages});

  StudentModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    firstName = json["first_name"];
    lastName = json["last_name"];
    studentId = json["student_id"];
    faculty = json["faculty"];
    licensePartOne = json["licensePartOne"];
    licensePartTwo = json["licensePartTwo"];
    licensePartThree = json["licensePartThree"];
    image = json["image"];
    uploadedCardImages = json["uploadedCardImages"];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["first_name"] = firstName;
    _data["last_name"] = lastName;
    _data["student_id"] = studentId;
    _data["faculty"] = faculty;
    _data["licensePartOne"] = licensePartOne;
    _data["licensePartTwo"] = licensePartTwo;
    _data["licensePartThree"] = licensePartThree;
    _data["image"] = image;
    _data["uploadedCardImages"] = uploadedCardImages;

    return _data;
  }
}
