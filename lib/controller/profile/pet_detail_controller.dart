import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petwarden/controller/core_controller.dart';
import 'package:petwarden/model/pet_model.dart';
import 'package:petwarden/utils/constants/pet_types.dart';

class PetDetailController extends GetxController {
  final cc = Get.find<CoreController>();
  Rxn<Pet> pet = Rxn();
  var petNameController = TextEditingController();
  var petAgeController = TextEditingController();
  var habitsController = TextEditingController();
  RxString selectedGender = RxString("male");
  PetConstants constants = PetConstants();

  List<String> petTypes = [];
  Map<String, List<String>> breedMap = {};

  final List<String> vaccinationStatus = [
    'Vaccinated',
    'Not Vaccinated',
  ];
  RxString selectedPetType = "Dog".obs;
  RxString selectedBreed = "Lab".obs;
  RxList<String> breeds = RxList<String>(["Lab", "German"]);
  RxString selectedVaccinationStatus = "Vaccinated".obs;
  late Rx<String> profilePicPath = Rx<String>('');

  @override
  void onInit() {
    petTypes = constants.petTypes;
    breedMap = constants.breedMap;
    loadPetData();
    updateBreeds();
    super.onInit();
  }

  void loadPetData() {
    pet.value = cc.currentPet.value;
    profilePicPath.value = pet.value?.profileImage ?? "";
    petNameController.text = pet.value?.name ?? "";
    selectedPetType.value = pet.value?.type ?? "Dog";
    selectedBreed.value = pet.value?.type ?? "Lab";
    petAgeController.text = pet.value?.age ?? "";
    // selectedGender.value = pet.value?.gender ?? "Male";
    selectedVaccinationStatus.value = pet.value?.vaccinationStatus ?? "Vaccinated";
    habitsController.text = pet.value?.preferences ?? "";
    if (pet.value?.gender == "male") {
      selectedGender.value = "Male";
    } else {
      selectedGender.value = "Female";
    }
  }

  void updateBreeds() {
    breeds.value = breedMap[selectedPetType.value] ?? [];
    selectedBreed.value = breeds.first;
  }

  void changeGender(String? gender) {
    selectedGender.value = gender ?? "Female";
  }

  void pickImage(XFile pickedImage) async {
    final bytes = File(pickedImage.path).readAsBytesSync();
    String base64Image = base64Encode(bytes);
    print("this is the image $base64Image");
    profilePicPath.value = base64Image;
  }
}
