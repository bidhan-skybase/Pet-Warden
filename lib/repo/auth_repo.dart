import 'dart:convert';
import 'package:petwarden/model/access_token_model.dart';
import 'package:petwarden/model/pet_model.dart';
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

      if (data['status']) {
        var user = User.fromJson(data['data']);
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

  static Future<void> signInAsOwner({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required String petName,
    required String profilePicture,
    required Function(User user) onSuccess,
    required Function(String message) onError,
  }) async {
    String url = Api.signUpUrl;
    var body = {
      "name": fullName,
      "password": password,
      "phone": phone,
      "email": email,
      "pet_name": petName,
      "profile_image": profilePicture
    };
    http.Response response = await PetRequest.post(url, body: body);
    dynamic data = json.decode(response.body);
    if (data['status']) {
      var user = User.fromJson(data['data']);
      var accessToken = AccessToken.fromJson(data['data']['token']);
      StorageHelper.saveToken(accessToken);
      StorageHelper.saveOwner(user);
      onSuccess(user);
    } else {
      onError(data['message']);
    }
  }

  static Future<void> createPetProfile({
    required String petName,
    required String type,
    required String species,
    required String age,
    required String gender,
    required String vaccinationStatus,
    required String preferneces,
    required String imageUrl,
    required Function(Pet pet) onSuccess,
    required Function(String message) onError,
  }) async {
    String url = Api.createPetProfileUrl;
    var body = {
      "name": petName,
      "age": age,
      "type": type,
      "species": species,
      "gender": gender,
      "preferences": preferneces,
      "vaccination_status": vaccinationStatus,
      "image_url": imageUrl
    };
    http.Response response = await PetRequest.post(url, body: body);
    dynamic data = json.decode(response.body);
    if (data['status']) {
      var pet = Pet.fromJson(data['data']);
      StorageHelper.savePet(pet);
      onSuccess(pet);
    } else {
      onError(data['message']);
    }
  }

  static Future<void> sendOTP({
    required String email,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.sendOTPUrl;
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

  static Future<void> verifyOTP({
    required int userId,
    required String otp,
    required Function(bool status, String message) onSuccess,
  }) async {
    try {
      String url = Api.verifyOTPUrl;
      var body = {"user_id": userId, "otp": otp};
      http.Response response = await PetRequest.post(url, body: body);
      dynamic data = json.decode(response.body);
      onSuccess(data["status"], data["message"]);
    } catch (e, s) {
      LogHelper.error(e.toString());
      LogHelper.error(s.toString());
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

  static Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required Function(bool status, String message) onSuccess,
  }) async {
    try {
      String url = Api.changePasswordUrl;
      var body = {"old_password": oldPassword, "new_password": newPassword};
      http.Response response = await PetRequest.post(url, body: body);
      dynamic data = json.decode(response.body);
      onSuccess(data["status"], data["message"]);
    } catch (e, s) {
      LogHelper.error(e.toString());
      LogHelper.error(s.toString());
    }
  }
}
