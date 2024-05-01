import 'dart:convert';
import 'package:petwarden/model/access_token_model.dart';
import 'package:petwarden/model/user_model.dart';
import 'package:petwarden/utils/constants/api.dart';
import 'package:http/http.dart' as http;
import 'package:petwarden/utils/helper/log_helper.dart';
import 'package:petwarden/utils/helper/request_helper.dart';
import 'package:petwarden/utils/helper/storage-helper.dart';

class AuthRepo {
  static Future<void> loginAsOwner({
    required String email,
    required String password,
    required Function(User user) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.loginUrl;
      var body = {
        "email": email,
        "password": password,
      };
      http.Response response = await PetRequest.post(url, body: body);
      dynamic data = json.decode(response.body);
      print("----------------------$data");

      if (data['status']) {
        var user = User.fromJson(data['data']);
        print("0--------------------$user");
        var accessToken = AccessToken.fromJson(data['data']['token']);
        LogHelper.info("-------accesstoken ----> $accessToken");
        StorageHelper.saveToken(accessToken);
        StorageHelper.saveOwner(user);
        onSuccess(user);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.loginUrl, error: e, stackTrace: s);
      onError("Error when logging in");
    }
  }

  static Future<void> forgotPassword({
    required String email,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.forgotPasswordUrl;
      var body = {"email": email};
      http.Response response = await PetRequest.post(url, body: body);
      dynamic data = json.decode(response.body);
      if (data['status']) {
        onSuccess(data['message']);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(e.toString());
      LogHelper.error(s.toString());
    }
  }
}
