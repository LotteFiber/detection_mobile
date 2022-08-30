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
  late String? uploadedImageCard;
  late String? uploadedImageEvent;
  late String? uploadedImageCardUUID;
  late String? uploadedImageEventUUID;
  late String? imageUUID;

  DataModel({
    this.id,
    this.licensePartOne,
    this.licensePartTwo,
    this.licensePartThree,
    this.charge,
    this.image,
    this.uploadedImages,
    this.uploadedImageCard,
    this.uploadedImageEvent,
    this.uploadedImageCardUUID,
    this.uploadedImageEventUUID,
    this.imageUUID,
  });

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    licensePartOne = json["top"];
    licensePartTwo = json["province"];
    licensePartThree = json["bottom"];
    charge = json["charge"];
    image = json["image"];
    uploadedImages = json["uploadedImages"];
    uploadedImageCard = json["uploadedImageCard"];
    uploadedImageEvent = json["uploadedImageEvent"];
    uploadedImageCardUUID = json["uploadedImageCardUUID"];
    uploadedImageEventUUID = json["uploadedImageEventUUID"];
    imageUUID = json["imageUUID"];
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
    _data["uploadedImageCard"] = uploadedImageCard;
    _data["uploadedImageEvent"] = uploadedImageEvent;
    _data["uploadedImageCardUUID"] = uploadedImageCardUUID;
    _data["uploadedImageEventUUID"] = uploadedImageEventUUID;
    _data["imageUUID"] = imageUUID;

    return _data;
  }
}
