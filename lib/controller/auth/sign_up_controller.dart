import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petwarden/repo/auth_repo.dart';
import 'package:petwarden/utils/constants/pet_types.dart';
import 'package:petwarden/utils/helper/pet_snackbar.dart';
import 'package:petwarden/view/auth/OTPverification_page.dart';
import 'package:petwarden/widgets/progress_dialog.dart';

import '../core_controller.dart';

class SignUpController extends GetxController {
  //form keys
  GlobalKey<FormState> signupKeyOwner = GlobalKey<FormState>();
  GlobalKey<FormState> signupKeyPet = GlobalKey<FormState>();

  final CoreController coreController = Get.find();
  PetConstants constants = PetConstants();

  //user
  late Rx<String> profilePicPath = Rx<String>('');
  late Rx<String> petPicPath = Rx<String>('');
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  //pet
  var petNameController = TextEditingController();
  var petAgeController = TextEditingController();
  var habitsController = TextEditingController();

  var hidePass = true.obs;
  var hideConPass = true.obs;

  ProgressDialog loading = ProgressDialog();

  RxString selectedGender = RxString("Male");

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

  void updateBreeds() {
    breeds.value = breedMap[selectedPetType.value] ?? [];
    selectedBreed.value = breeds.first;
  }

  void pickImage(XFile pickedImage) async {
    final bytes = File(pickedImage.path).readAsBytesSync();
    String base64Image = base64Encode(bytes);

    profilePicPath.value = base64Image;
  }

  void pickImagePet(XFile pickedImage) async {
    final bytes = File(pickedImage.path).readAsBytesSync();
    String base64Image = base64Encode(bytes);
    petPicPath.value = base64Image;
  }

  void onEyeClick() {
    hidePass.value = !hidePass.value;
  }

  void onConEyeClick() {
    hideConPass.value = !hideConPass.value;
  }

  void changeGender(String? gender) {
    selectedGender.value = gender ?? "Female";
  }

  Future<void> ownerSignUp() async {
    if (signupKeyOwner.currentState!.validate()) {
      loading.show();
      await AuthRepo.signInAsOwner(
          fullName: nameController.text,
          email: emailController.text,
          phone: phoneController.text,
          password: passwordController.text,
          petName: petNameController.text,
          profilePicture: profilePicPath.value,
          onSuccess: (user) async {
            coreController.loadCurrentUser();
            await createPetProfile();
          },
          onError: (msg) {
            loading.hide();
            PetSnackBar.error(message: msg);
          });
    }
  }

  Future<void> createPetProfile() async {
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
          loading.hide();
          Get.toNamed(OTPVerification.routeName);
        },
        onError: (msg) {
          PetSnackBar.error(message: msg);
          Get.back();
          Get.back();
        });
  }
}
