// Dart imports:
import 'dart:convert';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  // late final String message;
  late final Data data;
  late final String userName;

  LoginResponseModel(this.data, this.userName);

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    // message = json["message"];
    data = Data.fromJson(json["savedUser"]);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    // _data['message'] = message;
    _data['data'] = data.toJson();

    return _data;
  }
}

class Data {
  late final String userName;
  late final String userId;
  late final String token;

  Data({
    required this.userName,
    required this.userId,
    required this.token,
  });

  Data.fromJson(Map<String, dynamic> json) {
    userName = json["user_name"];
    userId = json["_id"];
    token = "token";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['userName'] = userName;
    _data['userId'] = userId;
    _data['token'] = token;

    return _data;
  }

  Data copyWith({String? userName}) {
    return Data(
      token: token,
      userName: userName ?? this.userName,
      userId: '',
    );
  }
}
