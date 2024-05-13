import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petwarden/controller/core_controller.dart';
import 'package:petwarden/model/user_model.dart';

class PetOwnerDetailController extends GetxController {
  var cc = Get.find<CoreController>();
  Rxn<User> owner = Rxn();
  late Rx<String> profilePicPath = Rx<String>('');
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  GlobalKey<FormState> ownerKey = GlobalKey<FormState>();

  @override
  void onInit() {
    loadOwner();
    super.onInit();
  }

  loadOwner() {
    owner.value = cc.currentUser.value;
    profilePicPath.value = owner.value?.profileImageUrl ?? "";
    nameController.text = owner.value?.name ?? "";
    emailController.text = owner.value?.email ?? "";
    phoneController.text = owner.value?.phone ?? "";
  }

  void pickImage(XFile pickedImage) async {
    final bytes = File(pickedImage.path).readAsBytesSync();
    String base64Image = base64Encode(bytes);

    profilePicPath.value = base64Image;
  }
}
