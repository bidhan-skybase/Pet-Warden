import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petwarden/controller/core_controller.dart';
import 'package:petwarden/model/pet_model.dart';
import 'package:petwarden/repo/profile_repo.dart';
import 'package:petwarden/utils/constants/pet_types.dart';
import 'package:petwarden/utils/helper/pet_snackbar.dart';
import 'package:petwarden/widgets/progress_dialog.dart';

class PetDetailController extends GetxController {
  final cc = Get.find<CoreController>();
  Rxn<Pet> pet = Rxn();
  var petNameController = TextEditingController();
  var petAgeController = TextEditingController();
  var habitsController = TextEditingController();
  RxString selectedGender = RxString("male");
  PetConstants constants = PetConstants();
  GlobalKey<FormState> petKey = GlobalKey<FormState>();
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
  final ProgressDialog loading = ProgressDialog();
  // RxList<Pet> allPets = <Pet>[].obs;

  @override
  void onInit() {
    petTypes = constants.petTypes;
    breedMap = constants.breedMap;
    var args = Get.arguments["pet"];
    if (args != null) {
      pet.value = args;
    }
    // allPets = cc.pets;
    loadPetData();
    updateBreeds();
    super.onInit();
  }

  void loadPetData() {
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
    profilePicPath.value = base64Image;
  }

  void onUpdate() async {
    if (petKey.currentState!.validate()) {
      loading.show();
      ProfileRepo.updatePetDetail(
          id: pet.value?.id ?? "",
          name: petNameController.text,
          age: petAgeController.text,
          gender: selectedGender.value,
          vaccination: selectedVaccinationStatus.value,
          bio: habitsController.text,
          profilePicture: profilePicPath.value,
          onSuccess: (pet) {
            cc.loadCurrentPet();
            loading.hide();
            PetSnackBar.success(
                title: "Your pet looks good",
                message: "Your pet profile has been updated successfully.");
          },
          onError: (message) {
            PetSnackBar.error(message: message);
          });
    }
  }
}
