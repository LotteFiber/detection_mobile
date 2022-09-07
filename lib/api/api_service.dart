// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:detection_mobile/config.dart';
import 'package:detection_mobile/const/appConst.dart';
import 'package:detection_mobile/models/data_model.dart';
import 'package:detection_mobile/models/datawoplate_model.dart';
import 'package:detection_mobile/models/login_response_model.dart';
import 'package:detection_mobile/utils/shared_service.dart';

final apiService = Provider((ref) => APIService());

class APIService {
  static var client = http.Client();

  // Save Plate Data
  static Future<bool> addData(
    DataModel model,
    bool isFileSelected,
  ) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiURL, Config.addDataAPI);
    var request = http.MultipartRequest("POST", url);
    if (model.uploadedImages != null && isFileSelected) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        "uploadedImages",
        model.uploadedImages!,
      );
      request.files.add(multipartFile);
    }
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "top": model.licensePartOne,
        "province": model.licensePartTwo,
        "bottom": model.licensePartThree,
        "charge": model.charge,
        "image": model.imageUUID,
        "imageCard": model.uploadedImageCardUUID,
        "imageEvent": model.uploadedImageEventUUID,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Save Card Data
  static Future<bool> addDataWOPlate(
    DataWOPlateModel model,
    bool isFileSelected,
  ) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiURL, Config.addDataWOPlateAPI);
    var request = http.MultipartRequest("POST", url);
    if (model.uploadedImageCard != null && isFileSelected) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        "uploadedImageCard",
        model.uploadedImageCard!,
      );
      request.files.add(multipartFile);
    }
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "first_name": model.firstName,
        "last_name": model.lastName,
        "student_id": model.studentId,
        "faculty": model.faculty,
        "charge": model.charge,
        "imageCard": model.uploadedImageCardUUID,
        "imageEvent": model.uploadedImageEventUUID,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

// Upload Image Card
  static Future<String> uploadImageCard(
    DataModel model,
    bool isFileSelected,
  ) async {
    var url = Uri.http(Config.apiURL, Config.uploadPlateImageAPI);
    var request = http.MultipartRequest("POST", url);

    if (model.uploadedImageCard != null && isFileSelected) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        "uploadedImages",
        model.uploadedImageCard!,
      );

      request.files.add(multipartFile);
    }
    var response = await request.send();
    if (response.statusCode == 200) {
      var res = await http.Response.fromStream(response);
      var jsonData = json.decode(res.body);
      AppConst.Temp_UUID = jsonData["uuid"];
      return jsonData["uuid"];
    } else {
      return "";
    }
  }

  // Upload Image Event
  static Future<String> uploadImageEvent(
    DataModel model,
    bool isFileSelected,
  ) async {
    var url = Uri.http(Config.apiURL, Config.uploadPlateImageAPI);
    var request = http.MultipartRequest("POST", url);

    if (model.uploadedImageEvent != null && isFileSelected) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        "uploadedImages",
        model.uploadedImageEvent!,
      );

      request.files.add(multipartFile);
    }
    var response = await request.send();
    if (response.statusCode == 200) {
      var res = await http.Response.fromStream(response);
      var jsonData = json.decode(res.body);
      return jsonData["uuid"];
    } else {
      return "";
    }
  }

  // Upload Image Event in DataWOPlate
  static Future<String> uploadImageEventInDataWOPlate(
    DataWOPlateModel model,
    bool isFileSelected,
  ) async {
    var url = Uri.http(Config.apiURL, Config.uploadPlateImageAPI);
    var request = http.MultipartRequest("POST", url);

    if (model.uploadedImageEvent != null && isFileSelected) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        "uploadedImages",
        model.uploadedImageEvent!,
      );

      request.files.add(multipartFile);
    }
    var response = await request.send();
    if (response.statusCode == 200) {
      var res = await http.Response.fromStream(response);
      var jsonData = json.decode(res.body);
      return jsonData["uuid"];
    } else {
      return "";
    }
  }

  // Verify Plate Image
  static Future<bool> addPlateImage(
    DataModel model,
    bool isFileSelected,
  ) async {
    var url = Uri.http(Config.apiURL, Config.addPlateImageAPI);
    var request = http.MultipartRequest("POST", url);
    if (model.uploadedImages != null && isFileSelected) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        "uploadedImages",
        model.uploadedImages!,
      );

      request.files.add(multipartFile);
    }

    var response = await request.send();
    var res = await http.Response.fromStream(response);

    var jsonData = json.decode(res.body);
    AppConst.Temp_UUID = jsonData["uuid"];

    if (response.statusCode == 200) {
      var url1 = Uri.http(Config.apiURL, Config.startProgramPlateImageAPI);
      var response1 = await client.post(url1, body: {
        "uuid": jsonData["uuid"],
      });
      if (response1.statusCode == 200) {
        return true;
      }
      return true;
    } else {
      return false;
    }
  }

  // Verify Card Image
  static Future<bool> addCardImage(
    DataWOPlateModel model,
    bool isFileSelected,
  ) async {
    var url = Uri.http(Config.apiURL, Config.addCardImageAPI);
    var request = http.MultipartRequest("POST", url);
    if (model.uploadedImageCard != null && isFileSelected) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        "uploadedImageCard",
        model.uploadedImageCard!,
      );

      request.files.add(multipartFile);
    }

    var response = await request.send();
    var res = await http.Response.fromStream(response);
    var jsonData = json.decode(res.body);
    AppConst.Temp_UUID = jsonData["uuid"];

    if (response.statusCode == 200) {
      var url1 = Uri.http(Config.apiURL, Config.startProgramCardImageAPI);
      var response1 = await client.post(url1, body: {
        "uuid": jsonData["uuid"],
      });
      if (response1.statusCode == 200) {
        return true;
      }
      return true;
    } else {
      return false;
    }
  }

  // Get Plate Details Data
  static Future getPlateImageData() async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(
        Config.apiURL, Config.getPlateImageDataAPI + AppConst.Temp_UUID + ".json");

    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    var jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      var len = jsonData.length;
      return jsonData[len - 1];
    } else {
      return null;
    }
  }

  // Get Card Details Data
  static Future getCardImageData() async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(
        Config.apiURL, Config.getCardImageDataAPI + AppConst.Temp_UUID + ".json");

    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var len = jsonData.length;
      return jsonData[len - 1];
    } else {
      return null;
    }
  }

  // Check Student Id
  static Future<bool> checkData(
    String studentId,
  ) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(Config.apiURL, Config.checkDataAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "student_id": studentId,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Get Count of Data
  static Future<int> getCount(String studentID) async {
    var url = Uri.http(Config.apiURL, Config.showDataDetailsAPI + "/" + studentID);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return jsonData.length;
    } else {
      return 0;
    }
  }

  // Register
  static Future<bool> registerUser(
    String userName,
    String password,
  ) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(Config.apiURL, Config.registerAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        {"user_name": userName, "pass_word": password},
      ),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Login
  static Future<bool> loginUser(
    String userName,
    String password,
  ) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(Config.apiURL, Config.loginAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        {"user_name": userName, "pass_word": password},
      ),
    );

    if (response.statusCode == 200) {
      LoginResponseModel loginResponseModel = loginResponseJson(response.body);

      AppConst.USER_NAME = loginResponseModel.data.userName;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', loginResponseModel.data.userName);
      await SharedService.setLoginDetails(loginResponseModel);
      return true;
    } else {
      return false;
    }
  }
}
