import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignUpController extends GetxController {

  //form keys
  GlobalKey<FormState> signupKeyUser = GlobalKey<FormState>();
  GlobalKey<FormState> signupKeyPet = GlobalKey<FormState>();
  GlobalKey<FormState> OTPKey = GlobalKey<FormState>();
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
  RxString selectedGender=RxString("Male");

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
  RxString selectedPetType="Dog".obs;
  RxString selectedBreed="Lab".obs;
  RxString selectedVaccinationStatus="Vaccinated".obs;

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

  void changeGender(String? gender){
    selectedGender.value=gender??"Female";
  }
}
