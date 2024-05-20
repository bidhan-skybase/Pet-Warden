import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petwarden/repo/auth_repo.dart';
import 'package:petwarden/utils/constants/pet_types.dart';
import 'package:petwarden/utils/helper/pet_snackbar.dart';
import 'package:petwarden/utils/helper/storage-helper.dart';

import '../../widgets/progress_dialog.dart';
import '../core_controller.dart';

class AddPetController extends GetxController {
  GlobalKey<FormState> signupKeyPet = GlobalKey<FormState>();
  late Rx<String> petPicPath = Rx<String>('');
  var petNameController = TextEditingController();
  var petAgeController = TextEditingController();
  var habitsController = TextEditingController();
  PetConstants constants = PetConstants();
  RxString selectedGender = RxString("Male");
  ProgressDialog loading = ProgressDialog();
  final CoreController coreController = Get.find();

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

  @override
  void onInit() {
    petTypes = constants.petTypes;
    breedMap = constants.breedMap;
    updateBreeds();
    super.onInit(); // Initialize breeds
  }

  void pickImagePet(XFile pickedImage) async {
    final bytes = File(pickedImage.path).readAsBytesSync();
    String base64Image = base64Encode(bytes);
    petPicPath.value = base64Image;
  }

  void updateBreeds() {
    breeds.value = breedMap[selectedPetType.value] ?? [];
    selectedBreed.value = breeds.first;
  }

  void changeGender(String? gender) {
    selectedGender.value = gender ?? "Female";
  }

  Future<void> createPetProfile() async {
    loading.show();
    await AuthRepo.createPetProfile(
        petName: petNameController.text,
        type: selectedPetType.value,
        species: selectedBreed.value,
        age: petAgeController.text,
        gender: selectedGender.value == "Male" ? "male" : "female",
        // gender: selectedGender.value,
        vaccinationStatus: selectedVaccinationStatus.value,
        preferneces: habitsController.text,
        imageUrl: petPicPath.value,
        onSuccess: (pet) async {
          coreController.loadCurrentPet();
          Get.back();
          PetSnackBar.success(
              title: " Profile Created", message: "Welcome aboard! Your adventure starts now.");
          loading.hide();
        },
        onError: (msg) {
          PetSnackBar.error(message: msg);
          Get.back();
          Get.back();
        });
  }
}
