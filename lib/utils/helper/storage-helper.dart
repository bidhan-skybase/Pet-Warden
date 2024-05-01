import 'dart:convert';
import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:petwarden/model/access_token_model.dart';
import 'package:petwarden/model/user_model.dart';
import 'package:petwarden/utils/constants/storage_keys.dart';
import 'package:petwarden/utils/helper/log_helper.dart';

class StorageHelper {
  static bool isOnboarded() {
    try {
      final box = GetStorage();
      bool onBoarded = box.read(StorageKeys.AppLoadDate);
      LogHelper.info("isOnboarded  value in storage --------$onBoarded");
      return onBoarded;
    } catch (e, s) {
      LogHelper.info("isOnboarded error function is called in-----------catch");
      return false;
    }
  }

  static Future<void> setOnBoarded() async {
    try {
      LogHelper.info("isOnboarded function is called    write --------storage helpers");
      final box = GetStorage();
      await box.write(StorageKeys.AppLoadDate, true);
    } catch (e) {
      LogHelper.info(e.toString());
    }
  }

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
}
