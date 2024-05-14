import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petwarden/controller/core_controller.dart';
import 'package:petwarden/repo/auth_repo.dart';
import 'package:petwarden/utils/helper/pet_snackbar.dart';
import 'package:petwarden/utils/helper/storage-helper.dart';
import 'package:petwarden/view/auth/OTPverification_page.dart';
import 'package:petwarden/view/dash_pages/dash_screen.dart';

class OTPController extends GetxController {
  var otpController = TextEditingController();
  final CoreController coreController = Get.find();
  GlobalKey<FormState> OTPKey = GlobalKey<FormState>();

  @override
  void onInit() async {
    await sendOTP();
    super.onInit();
  }

  Future<void> sendOTP() async {
    await AuthRepo.sendOTP(
        email: coreController.currentUser.value?.email ?? "",
        onSuccess: (message) {
          PetSnackBar.success(
              message: "Just one more step to start your pet's journey with Pet Warden!",
              title: "Just One Step Away! 🐾");
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
            var user = coreController.currentUser.value;
            user?.otpVerifiedAt = DateTime.now().toString();
            StorageHelper.saveOwner(user!);
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
