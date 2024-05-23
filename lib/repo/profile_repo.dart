import 'dart:convert';

import 'package:petwarden/model/access_token_model.dart';
import 'package:petwarden/model/pet_model.dart';
import 'package:petwarden/model/user_model.dart';
import 'package:petwarden/utils/constants/api.dart';
import 'package:http/http.dart' as http;
import 'package:petwarden/utils/helper/request_helper.dart';
import 'package:petwarden/utils/helper/storage-helper.dart';

class ProfileRepo {
  static Future<void> updateOwnerProfile({
    required String fullName,
    required String email,
    required String phone,
    required String profilePicture,
    required Function(User user) onSuccess,
    required Function(String message) onError,
  }) async {
    String url = Api.updateOwnerProfile;
    var body = {
      "name": fullName,
      "phone": phone,
      "email": email,
      if (profilePicture == "" && profilePicture.isNotEmpty) "profile_image_url": profilePicture,
    };
    http.Response response = await PetRequest.post(url, body: body);
    dynamic data = json.decode(response.body);
    if (data['status']) {
      var user = User.fromJson(data['user']);
      StorageHelper.saveOwner(user);
      onSuccess(user);
    } else {
      onError(data['message']);
    }
  }

  static Future<void> updatePetDetail({
    required String id,
    required String name,
    required String age,
    required String gender,
    required String vaccination,
    required String bio,
    required String profilePicture,
    required Function(Pet pet) onSuccess,
    required Function(String message) onError,
  }) async {
    String url = Api.updatePetProfile.replaceAll("#id#", id);
    var body = {
      "name": name,
      "age": age,
      "gender": gender.toLowerCase(),
      "preferences": bio,
      "vaccination_status": vaccination,
      if (profilePicture == "" && profilePicture.isNotEmpty) "image_url": profilePicture,
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

  static Future<void> deletePetProfile(
      {required String id, required Function(bool status) onComplete}) async {
    String url = Api.deletePetProfile.replaceAll("#id#", id);
    http.Response response = await PetRequest.post(url);
    dynamic data = json.decode(response.body);
    if (data['status']) {
      StorageHelper.deletePet(id);
      onComplete(true);
    } else {
      onComplete(false);
    }
  }

  static Future<void> deleteAccount({required Function(bool status) onComplete}) async {
    String url = Api.deleteAccount;
    http.Response response = await PetRequest.post(url);
    dynamic data = json.decode(response.body);
    if (data['status']) {
      onComplete(true);
    } else {
      onComplete(false);
    }
  }
}
