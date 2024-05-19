import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petwarden/controller/core_controller.dart';
import 'package:petwarden/model/user_model.dart';
import 'package:petwarden/repo/profile_repo.dart';
import 'package:petwarden/utils/helper/pet_snackbar.dart';
import 'package:petwarden/widgets/progress_dialog.dart';

class PetOwnerDetailController extends GetxController {
  var cc = Get.find<CoreController>();
  Rxn<User> owner = Rxn();
  late Rx<String> profilePicPath = Rx<String>('');
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  GlobalKey<FormState> ownerKey = GlobalKey<FormState>();
  final ProgressDialog loading = ProgressDialog();

  @override
  void onInit() {
    loadOwner();
    super.onInit();
  }

  loadOwner() {
    owner.value = cc.currentUser.value;
    nameController.text = owner.value?.name ?? "";
    emailController.text = owner.value?.email ?? "";
    phoneController.text = owner.value?.phone ?? "";
  }

  void pickImage(XFile pickedImage) async {
    final bytes = File(pickedImage.path).readAsBytesSync();
    String base64Image = base64Encode(bytes);

    profilePicPath.value = base64Image;
  }

  void onUpdate() async {
    if (ownerKey.currentState!.validate()) {
      loading.show();
      ProfileRepo.updateOwnerProfile(
          fullName: nameController.text,
          email: emailController.text,
          phone: phoneController.text,
          profilePicture: profilePicPath.value,
          onSuccess: (updatedUser) {
            cc.loadCurrentUser();
            loading.hide();
            PetSnackBar.success(
                title: "Looking Good 😎", message: "Your profile has been updated successfully.");
          },
          onError: (message) {
            loading.hide();
            PetSnackBar.error(message: message);
          });
    }
  }
}
