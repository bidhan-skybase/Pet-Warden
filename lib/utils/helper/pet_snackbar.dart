import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/view/auth/log_in_screen.dart';

class PetSnackBar {
  static bool isNoInternetShown = false;
  static success({String? title, String? message, VoidCallback? onTap}) {
    Get.snackbar(title ?? "Successful", message ?? "The action was successful!",
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        backgroundColor: Colors.green, onTap: (snack) {
      if (onTap != null) {
        onTap();
      }
    }, colorText: Colors.white);
  }

  static info({String? title, required String message}) {
    Get.snackbar(title ?? "Info", message,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        backgroundColor: PetWardenColors.primaryColor,
        colorText: Colors.white);
  }

  static error({String? title, String? message}) {
    Get.snackbar(title ?? "Error!", message ?? "Unknown error! Please try again later!",
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        backgroundColor: PetWardenColors.errorColor,
        colorText: Colors.white);
  }

  static noInternetConnection({required VoidCallback onTap}) {
    if (!isNoInternetShown) {
      isNoInternetShown = true;
      Get.snackbar("No Internet", "Please check your internet connection and try again",
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          backgroundColor: PetWardenColors.errorColor,
          dismissDirection: DismissDirection.none,
          duration: null,
          colorText: Colors.black,
          isDismissible: false,
          mainButton: TextButton(onPressed: onTap, child: const Text("Check Connection")));
    }
  }

  static login(String? title, String? message) {
    if (!isNoInternetShown) {
      Get.snackbar(title ?? "Error", message ?? "Unknown error! Please try again later",
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          backgroundColor: const Color.fromARGB(255, 120, 188, 155),
          colorText: Colors.black,
          mainButton: TextButton(
              onPressed: () {
                Get.toNamed(LogInScreen.routeName);
              },
              child: const Text("LogIn")));
    }
  }
}
