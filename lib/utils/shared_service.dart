// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:detection_mobile/const/appConst.dart';
import 'package:detection_mobile/models/login_response_model.dart';

class SharedService {
  static const String KEY_NAME = "login_key";

  static Future<bool> isLoggedIn() async {
    var isCacheKeyExist = await APICacheManager().isAPICacheKeyExist(KEY_NAME);

    final prefs = await SharedPreferences.getInstance();
    final String? username = prefs.getString('username');
    if (username == null) {
      return false;
    }
    print(username);
    AppConst.USER_NAME = username;

    return isCacheKeyExist;
  }

  static Future<void> setLoginDetails(LoginResponseModel model) async {
    APICacheDBModel cacheDBModel = APICacheDBModel(
      key: KEY_NAME,
      syncData: jsonEncode(model.toJson()),
    );

    await APICacheManager().addCacheData(cacheDBModel);
  }

  static Future<LoginResponseModel?> loginDetails() async {
    var isCacheKeyExist = await APICacheManager().isAPICacheKeyExist(KEY_NAME);

    if (isCacheKeyExist) {
      var cacheData = await APICacheManager().getCacheData(KEY_NAME);

      return loginResponseJson(cacheData.syncData);
    }
    return null;
  }

  static Future<void> logout(BuildContext context) async {
    await APICacheManager().deleteCache(KEY_NAME);
    Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
  }
}
