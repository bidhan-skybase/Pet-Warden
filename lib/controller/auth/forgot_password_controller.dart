import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:petwarden/repo/auth_repo.dart';
import 'package:petwarden/utils/helper/pet_snackbar.dart';

class ForgotPasswordController extends GetxController {
  var emailController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Future<void> onSubmit() async {
    if (formkey.currentState!.validate()) {
      await AuthRepo.forgotPassword(
          email: emailController.text,
          onSuccess: (msg) {
            PetSnackBar.success(message: msg);
            Get.back();
          },
          onError: (msg) {
            PetSnackBar.error(message: msg);
          });
    }
  }
}
