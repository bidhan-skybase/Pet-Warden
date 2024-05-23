import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petwarden/controller/core_controller.dart';
import 'package:petwarden/model/sitter_staff_model.dart';
import 'package:petwarden/model/sitters_model.dart';
import 'package:petwarden/model/user_model.dart';

class SitterDetailController extends GetxController {
  final cc = Get.find<CoreController>();
  Rxn<SitterStaff> sitterInfo = Rxn();
  Rxn<User> user = Rxn();

  GlobalKey<FormState> sitterKey = GlobalKey<FormState>();

  late Rx<String> profilePicPath = Rx<String>('');
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var biocontroller = TextEditingController();

  List<Reviews> reviews = [];

  @override
  void onInit() {
    loadUserData();
    loadAdditionalData();
    super.onInit();
  }

  loadUserData() {
    user.value = cc.currentUser.value;
    nameController.text = user.value?.name ?? "";
    emailController.text = user.value?.email ?? "";
    phoneController.text = user.value?.phone ?? "";
  }

  loadAdditionalData() {
    sitterInfo.value = cc.currentStaff.value;
    reviews = sitterInfo.value?.staff?.reviews ?? [];
    biocontroller.text = sitterInfo.value?.extraDetails?.bio ?? "";
  }

  void pickImage(XFile pickedImage) async {
    final bytes = File(pickedImage.path).readAsBytesSync();
    String base64Image = base64Encode(bytes);
    profilePicPath.value = base64Image;
  }
}
