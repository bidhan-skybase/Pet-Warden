import 'dart:convert';
import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:petwarden/model/access_token_model.dart';
import 'package:petwarden/model/pet_model.dart';
import 'package:petwarden/model/user_model.dart';
import 'package:petwarden/utils/constants/storage_keys.dart';

class StorageHelper {
  static saveUserType(String userType) {
    try {
      final box = GetStorage();
      box.write(StorageKeys.UserType, userType);
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      throw "Unable to save User Type";
    }
  }

  static String? getUserType() {
    try {
      final box = GetStorage();
      String userType = box.read(StorageKeys.UserType);
      return userType;
    } catch (e, s) {
      log("Unable to fetch User Type");
      log(e.toString());
      log(s.toString());
      return null;
    }
  }

  static saveOwner(User user) {
    try {
      final box = GetStorage();
      box.write(StorageKeys.Owner, json.encode(user.toJson()));
      log(("Customer Saved"));
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      throw "Unable to save Customer";
    }
  }

  static User? getOwner() {
    try {
      final box = GetStorage();
      log("====================> Customer");
      log(box.read(StorageKeys.Owner));
      User user = User.fromJson(json.decode(box.read(StorageKeys.Owner)));
      return user;
    } catch (e, s) {
      log("Unable to fetch Customer");
      log(e.toString());
      log(s.toString());
      return null;
    }
  }

  static savePet(Pet pet) {
    try {
      final box = GetStorage();
      box.write(StorageKeys.Pet, json.encode(pet.toJson()));
      log(("pet Saved"));
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      throw "Unable to save pet";
    }
  }

  static Pet? getPet() {
    try {
      final box = GetStorage();
      log("====================> Customer");
      log(box.read(StorageKeys.Pet));
      Pet pet = Pet.fromJson(json.decode(box.read(StorageKeys.Pet)));
      return pet;
    } catch (e, s) {
      log("Unable to fetch pet");
      log(e.toString());
      log(s.toString());
      return null;
    }
  }

  // static saveEmployee(Employee employee) {
  //   try {
  //     final box = GetStorage();
  //     box.write(StorageKeys.Employee, json.encode(employee.toJson()));
  //     log(("Employee Saved"));
  //   } catch (e, s) {
  //     log(e.toString());
  //     log(s.toString());
  //     throw "Unable to save Employee";
  //   }
  // }

  // static Employee? getEmployee() {
  //   try {
  //     final box = GetStorage();
  //     log("====================> Employee");
  //     log(box.read(StorageKeys.Employee));
  //     Employee employee =
  //         Employee.fromJson(json.decode(box.read(StorageKeys.Employee)));
  //     return employee;
  //   } catch (e, s) {
  //     log("Unable to fetch Employee");
  //     log(e.toString());
  //     log(s.toString());
  //     return null;
  //   }
  // }

  static saveToken(AccessToken token) {
    try {
      final box = GetStorage();
      box.write(StorageKeys.Token, json.encode(token.toJson()));
      log("Token Saved ==========>");
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      throw "Unable to save token";
    }
  }

  static AccessToken? getToken() {
    try {
      final box = GetStorage();
      AccessToken token = AccessToken.fromJson(jsonDecode(box.read(StorageKeys.Token)) ?? "");
      return token;
    } catch (e) {
      return null;
    }
  }

  // static saveOnboarded(String onboarded) {
  //   try {
  //     final box = GetStorage();
  //     box.write(StorageKeys.isOnboarded, onboarded);
  //     log("Token Saved ==========>");
  //   } catch (e, s) {
  //     log(e.toString());
  //     log(s.toString());
  //     throw "Unable to save token";
  //   }
  // }
  static Future<void> saveOnboarded(String onboarded) async {
    try {
      final box = GetStorage();
      await box.write(StorageKeys.isOnboarded, onboarded);
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
    }
  }

  static String? getOnboarded() {
    try {
      final box = GetStorage();
      String isOnboarded = box.read(StorageKeys.isOnboarded);
      print(box.read(StorageKeys.isOnboarded));
      return isOnboarded;
    } catch (e) {
      return null;
    }
  }
}
