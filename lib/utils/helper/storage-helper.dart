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
      log(e.toString());
      log(s.toString());
      return null;
    }
  }

  static savePet(Pet pet) {
    try {
      final box = GetStorage();
      // Retrieve the current list of pets from storage
      String? petsJson = box.read(StorageKeys.Pet);
      List<Pet> pets = [];
      if (petsJson != null) {
        List<dynamic> petsList = json.decode(petsJson);
        pets = petsList.map((petMap) => Pet.fromJson(petMap)).toList();
      }
      // Check if a pet with the same ID already exists
      int index = pets.indexWhere((p) => p.id == pet.id);
      if (index != -1) {
        // Replace the existing pet
        pets[index] = pet;
      } else {
        // Add the new pet to the list
        pets.add(pet);
      }
      // Convert the updated list of pets to JSON and save it
      String updatedPetsJson = json.encode(pets.map((pet) => pet.toJson()).toList());
      box.write(StorageKeys.Pet, updatedPetsJson);
      log("Pet saved");
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      throw "Unable to save pet";
    }
  }

  static List<Pet>? getPets() {
    try {
      final box = GetStorage();
      log("====================> Fetching Pets");
      String? petsJson = box.read(StorageKeys.Pet);
      if (petsJson != null) {
        List<dynamic> petsList = json.decode(petsJson);
        List<Pet> pets = petsList.map((petMap) => Pet.fromJson(petMap)).toList();
        return pets;
      } else {
        log("No pets found in storage");
        return null;
      }
    } catch (e, s) {
      log("Unable to fetch pets");
      log(e.toString());
      log(s.toString());
      return null;
    }
  }

  static deletePet(String id) {
    try {
      final box = GetStorage();
      // Retrieve the current list of pets from storage
      String? petsJson = box.read(StorageKeys.Pet);
      if (petsJson != null) {
        List<dynamic> petsList = json.decode(petsJson);
        List<Pet> pets = petsList.map((petMap) => Pet.fromJson(petMap)).toList();
        // Remove the pet with the given ID
        pets.removeWhere((pet) => pet.id == id);
        // Convert the updated list of pets to JSON and save it
        String updatedPetsJson = json.encode(pets.map((pet) => pet.toJson()).toList());
        box.write(StorageKeys.Pet, updatedPetsJson);
        log("Pet deleted");
      } else {
        log("No pets found in storage to delete");
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      throw "Unable to delete pet";
    }
  }

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
