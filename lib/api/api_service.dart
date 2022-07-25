import 'dart:convert';
import 'package:detection_mobile/const/appConst.dart';
import 'package:detection_mobile/models/student_model.dart';
import 'package:http/http.dart' as http;
import 'package:detection_mobile/config.dart';
import 'package:detection_mobile/models/login_response_model.dart';
import 'package:detection_mobile/utils/shared_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/data_model.dart';

final apiService = Provider((ref) => APIService());

class APIService {
  static var client = http.Client();

  // addData
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
        "image": model.uploadedImages,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // addData with Image
  static Future<bool> addDataWithImage(
    DataModel model,
    bool isFileSelected,
  ) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiURL, Config.uploadPlateImage);
    var request = http.MultipartRequest("POST", url);
    print("Fir:" + model.uploadedImages.toString());
    if (model.uploadedImages != null && isFileSelected) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        "uploadedImages",
        model.uploadedImages!,
      );

      request.files.add(multipartFile);
    }
    var response = await request.send();
    if (response.statusCode == 200) {
      var url1 = Uri.http(Config.apiURL, Config.addDataAPI);
      // var request1 = http.MultipartRequest("POST", url);
      var response1 = await client.post(
        url1,
        headers: requestHeaders,
        body: jsonEncode({
          "top": model.licensePartOne,
          "province": model.licensePartTwo,
          "bottom": model.licensePartThree,
          "charge": model.charge,
          "image": model.uploadedImages,
          "imageCard": model.uploadedImageCard,
          "imageEvent": model.uploadedImageEvent,
        }),
      );
      if (response1.statusCode == 200) {
        return true;
      }
      return true;
    } else {
      return false;
    }
  }

  // addImagePlate
  static Future<bool> addPlateImage(
    DataModel model,
    bool isFileSelected,
  ) async {
    var url = Uri.http(Config.apiURL, Config.addPlateImage);
    var request = http.MultipartRequest("POST", url);
    print("Fir:" + model.uploadedImages.toString());
    if (model.uploadedImages != null && isFileSelected) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        "uploadedImages",
        model.uploadedImages!,
      );

      request.files.add(multipartFile);
    }

    var response = await request.send();
    var res = await http.Response.fromStream(response);

    var jasonData = json.decode(res.body);
    AppConst.Temp_UUID = jasonData["uuid"];
    if (response.statusCode == 200) {
      var url1 = Uri.http(Config.apiURL, Config.startProgramImage);
      var response1 = await client.post(url1, body: {
        "uuid": jasonData["uuid"],
      });
      print(response1.body.toString());
      if (response1.statusCode == 200) {
        return true;
      }
      return true;
    } else {
      return false;
    }
  }

  //get data for image
  static Future getImageData() async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(
        Config.apiURL, Config.getImageData + AppConst.Temp_UUID + ".json");
    print(Config.getImageData + AppConst.Temp_UUID + ".json");
    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    var jasonData = json.decode(response.body);
    if (response.statusCode == 200) {
      AppConst.Temp_UUID = "";
      var len = jasonData.length;
      return jasonData[len - 1];
    } else {
      return null;
    }
  }

  // addStudent
  static Future<bool> addStudent(
    String firstName,
    String lastName,
    String studentId,
    String faculty,
    String licensePartOne,
    String licensePartTwo,
    String licensePartThree,
  ) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(Config.apiURL, Config.addStudentAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "first_name": firstName,
        "last_name": lastName,
        "student_id": studentId,
        "faculty": faculty,
        "licensepartone": licensePartOne,
        "licenseparttwo": licensePartTwo,
        "licensepartthree": licensePartThree,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // addIdCard
  static Future<bool> addIdCard(
    StudentModel model,
    bool isFileSelected,
  ) async {
    var url = Uri.http(Config.apiURL, Config.addIdCard);
    var request = http.MultipartRequest("POST", url);

    if (model.uploadedCardImages != null && isFileSelected) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        "uploadedCardImages",
        model.uploadedCardImages!,
      );

      request.files.add(multipartFile);
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
      var url2 = Uri.http(Config.apiURL, Config.startProgramCardImage);
      var response2 = await client.post(url2, headers: requestHeaders);
      if (response2.statusCode == 200) {
        return true;
      }
      return true;
    } else {
      return false;
    }
  }

  // checkData
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

  //get count
  static Future<int> getCount(String studentID) async {
    var url = Uri.http(Config.apiURL, Config.showDataDetails + "/" + studentID);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return jsonData.length;
    } else {
      return 0;
    }
  }

  // getDataDetails
  Future<StudentModel?> getDataDetails(String studentId) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(Config.apiURL, Config.showDataDetails + "/" + studentId);
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<Data> datas = [];
      for (var d in data) {
        Data data = Data(
            d["first_name"],
            d["last_name"],
            d["faculty"],
            d["student_id"],
            d["licensepartone"],
            d["licenseparttwo"],
            d["licensepartthree"]);

        datas.add(data);
      }

      return StudentModel.fromJson(data["data"]);
    } else {
      return null;
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
      //print(loginResponseModel.data.userName);
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

class Data {
  final String first_name;
  final String last_name;
  final String faculty;
  final String student_id;
  final String licensepartone;
  final String licenseparttwo;
  final String licensepartthree;

  Data(this.first_name, this.last_name, this.faculty, this.student_id,
      this.licensepartone, this.licenseparttwo, this.licensepartthree);
}
