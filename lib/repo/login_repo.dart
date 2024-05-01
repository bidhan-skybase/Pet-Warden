import 'dart:convert';
import 'package:petwarden/model/access_token_model.dart';
import 'package:petwarden/model/user_model.dart';
import 'package:petwarden/utils/constants/api.dart';
import 'package:http/http.dart' as http;
import 'package:petwarden/utils/helper/log_helper.dart';
import 'package:petwarden/utils/helper/request_helper.dart';
import 'package:petwarden/utils/helper/storage-helper.dart';

class LoginRepo {
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
        var user = User.fromJson(data['data']['user']);
        print("0--------------------$user");
        var accessToken = AccessToken.fromJson(data['data']['user']['token']);

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

  // static Future<void> loginAsEmployee(
  //     {required String email,
  //     required String password,
  //     required Function(Employee employee, Token token) onSuccess,
  //     required Function(String message) onError}) async {
  //   try {
  //     var headers = {"Accept": "application/json"};

  //     var body = {
  //       "phone": email,
  //       "password": password,
  //     };

  //     http.Response response = await BhokRequest.post(
  //       Uri.parse(Api.riderLogin),
  //       headers: headers,
  //       body: body
  //     );

  //     log("${Api.riderLogin} ===================>");
  //     log(response.body);

  //     dynamic data = json.decode(response.body);

  //     if(data['success']){
  //       Employee employee = Employee.fromJson(data['data']["user"]);
  //       Token token = Token.fromJson(data['data']["token"]);
  //       onSuccess(employee, token);
  //     }else{
  //       onError(data['message']);
  //     }

  //   } catch (e, s) {
  //     log(e.toString());
  //     log(s.toString());
  //     onError("Sorry Something went wrong");
  //   }
  // }
}
