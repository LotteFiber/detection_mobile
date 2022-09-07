class Config {
  static const String appName = "Helmet.sys";

  // Base URL
  static const String apiURL = "10.0.2.2:5000"; // url debug on virtual emulator
  // static const String apiURL = "localhost:5000"; // url debug on physical device

  // Save Plate and Card Data
  static const String addDataAPI = "api/insertdatabyapp";
  static const String addDataWOPlateAPI = "api/insertdatabyappwoplate";

  // Verify Plate Image
  static const String addPlateImageAPI = "api/upload-file-image";
  static const String startProgramPlateImageAPI = "api/video/startProgramImage";

  // Verify Card Image
  static const String addCardImageAPI = "api/upload-file-card-image";
  static const String startProgramCardImageAPI = "api/video/startProgramCardImage";

  // Upload Card, Event and Event in DataWOPlate
  static const String uploadPlateImageAPI = "api/upload-image-plate";

  // Get Detail Data from Plate and Card
  static const String getPlateImageDataAPI = "api/data/image/data-";
  static const String getCardImageDataAPI = "api/data/image/dataCard-";
  
  // Check and Show Data
  static const String checkDataAPI = "api/check-data";
  static const String showDataDetailsAPI = "api/show-data";

  // Auth 
  static const String registerAPI = "api/signup";
  static const String loginAPI = "api/signin";
}
