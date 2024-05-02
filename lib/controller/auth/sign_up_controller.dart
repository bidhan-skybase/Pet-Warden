import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petwarden/model/pet_model.dart';
import 'package:petwarden/repo/auth_repo.dart';
import 'package:petwarden/utils/helper/pet_snackbar.dart';
import 'package:petwarden/view/auth/OTPverification_page.dart';
import 'package:petwarden/view/dash_pages/dash_screen.dart';
import 'package:petwarden/widgets/progress_dialog.dart';

import '../core_controller.dart';

class SignUpController extends GetxController {
  //form keys
  GlobalKey<FormState> signupKeyOwner = GlobalKey<FormState>();
  GlobalKey<FormState> signupKeyPet = GlobalKey<FormState>();
  GlobalKey<FormState> OTPKey = GlobalKey<FormState>();
  final CoreController coreController = Get.find();

  //user
  late Rx<String> profilePicPath = Rx<String>('http://surl.li/rkdax');
  late Rx<String> petPicPath = Rx<String>('http://surl.li/rkdax');
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  //pet
  var petNameController = TextEditingController();
  var petAgeController = TextEditingController();
  var habitsController = TextEditingController();
  var otpController = TextEditingController();

  var hidePass = true.obs;
  var hideConPass = true.obs;

  ProgressDialog loading = ProgressDialog();

  RxString selectedGender = RxString("male");

  final List<String> petTypes = [
    'Dog',
    'Cat',
  ];

  final List<String> breed = [
    'Lab',
    'German',
  ];

  final List<String> vaccinationStatus = [
    'Vaccinated',
    'Not Vaccinated',
  ];
  RxString selectedPetType = "Dog".obs;
  RxString selectedBreed = "Lab".obs;
  RxString selectedVaccinationStatus = "Vaccinated".obs;

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profilePicPath.value = pickedFile.path;
    }
  }

  Future<void> pickPetImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      petPicPath.value = pickedFile.path;
    }
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
        gender: selectedGender.value,
        vaccinationStatus: selectedVaccinationStatus.value,
        preferneces: habitsController.text,
        onSuccess: (pet) async {
          coreController.loadCurrentPet();
          loading.hide();
          await sendOTP();
        },
        onError: (msg) {
          PetSnackBar.error(message: msg);
          Get.back();
          Get.back();
        });
  }

  Future<void> sendOTP() async {
    await AuthRepo.sendOTP(
        email: coreController.currentUser.value?.email ?? "",
        onSuccess: (message) {
          PetSnackBar.success(
              message: "Just one more step to start your pet's journey with Pet Warden!",
              title: "Just One Step Away! 🐾");
          Get.offNamed(OTPVerification.routeName);
        },
        onError: (message) {
          PetSnackBar.error(message: message);
          Get.back();
        });
  }

  Future<void> verifyOTP() async {
    await AuthRepo.verifyOTP(
        userId: coreController.currentUser.value!.id!,
        otp: otpController.text,
        onSuccess: (status, message) {
          if (status == true) {
            Get.offAllNamed(DashPage.routeName);
            PetSnackBar.success(
                message:
                    "You've unlocked the gates! Welcome to Pet Warden - where every paw-sibility awaits!",
                title: "OTP Verified! Let's Dive In! 🎉");
          } else {
            Get.back();
            PetSnackBar.error(message: message);
          }
        });
  }
}
