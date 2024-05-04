import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petwarden/controller/core_controller.dart';
import 'package:petwarden/repo/auth_repo.dart';
import 'package:petwarden/utils/helper/pet_snackbar.dart';
import 'package:petwarden/view/dash_pages/dash_screen.dart';
import 'package:petwarden/widgets/progress_dialog.dart';

class LoginController extends GetxController {
  var hidePass = true.obs;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  GlobalKey<FormState> signinKey = GlobalKey<FormState>();

  final CoreController coreController = Get.find();
  ProgressDialog loading = ProgressDialog();

  void onEyeClick() {
    hidePass.value = !hidePass.value;
  }

  Future<void> onSubmit() async {
    if (signinKey.currentState!.validate()) {
      loading.show();
      await AuthRepo.loginAsOwner(
          email: emailController.text,
          password: passwordController.text,
          onSuccess: (user) {
            coreController.loadCurrentUser();
            loading.hide();
            PetSnackBar.success(
                title: "Welcome Back! 🐾",
                message: "You're now logged in. Let the pet adventures begin!");
            Get.offAllNamed(DashPage.routeName);
          },
          onError: (message) {
            PetSnackBar.error(title: "Login Failed", message: message);
            loading.hide();
          });
    }
  }
}
