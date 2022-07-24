List<DataModel> datasFromJson(dynamic str) =>
    List<DataModel>.from((str).map((x) => DataModel.fromJson(x)));

class DataModel {
  late String? id;
  late String? licensePartOne;
  late String? licensePartTwo;
  late String? licensePartThree;
  late String? charge;
  late String? image;
  late String? uploadedImages;
  late String? uploadedImagesCard;
  late String? uploadedImageEvent;

  DataModel({
    this.id,
    this.licensePartOne,
    this.licensePartTwo,
    this.licensePartThree,
    this.charge,
    this.image,
    this.uploadedImages,
    this.uploadedImagesCard,
    this.uploadedImageEvent,
  });

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    licensePartOne = json["top"];
    licensePartTwo = json["province"];
    licensePartThree = json["bottom"];
    charge = json["charge"];
    image = json["image"];
    uploadedImages = json["uploadedImages"];
    uploadedImagesCard = json["uploadedImagesCard"];
    uploadedImageEvent = json["uploadedImageEvent"];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["top"] = licensePartOne;
    _data["province"] = licensePartTwo;
    _data["bottom"] = licensePartThree;
    _data["charge"] = charge;
    _data["image"] = image;
    _data["uploadedImages"] = uploadedImages;
    _data["uploadedImagesCard"] = uploadedImagesCard;
    _data["uploadedImageEvent"] = uploadedImageEvent;

    return _data;
  }
}
