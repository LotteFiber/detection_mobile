class Config {
  static const String appName = "Helmet.sys";

  // Base URL
  // static const String apiURL = "10.0.2.2:5000"; // url debug on virtual emulator
  // static const String apiURL = "10.0.2.2:8080"; // url debug on Docker with nginx reverse proxy port
  // static const String apiURL = "localhost:5000"; // url debug on physical device
  static const String apiURL = "34.142.211.8"; // url for production

  // Auth
  static const String loginAPI = "api/signin";
  static const String registerAPI = "api/signup";

  // Check and Show Data
  static const String checkDataAPI = "api/check-data";
  static const String showDataDetailsAPI = "api/show-data";

  // Upload Card, Event and Event in DataWOPlate
  static const String uploadImageAPI = "api/upload-image";

  // Verify Plate Image
  static const String addPlateImageAPI = "api/upload-plate";
  static const String startProgramPlateImageAPI =
      "api/video/start-program-plate";

  // Verify Card Image
  static const String addCardImageAPI = "api/upload-card";
  static const String startProgramCardImageAPI = "api/video/start-program-card";

  // Get Detail Data from Plate and Card
  static const String getPlateImageDataAPI = "api/data/image/dataPlateJSON-";
  static const String getCardImageDataAPI = "api/data/image/dataCardJSON-";

  // Save Plate and Card Data
  static const String addDataAPI = "api/insertdatabyapp";
  static const String addDataWOPlateAPI = "api/insertdatabyappwoplate";
}
