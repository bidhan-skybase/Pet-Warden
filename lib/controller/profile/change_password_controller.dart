import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petwarden/repo/auth_repo.dart';
import 'package:petwarden/utils/helper/pet_snackbar.dart';
import 'package:petwarden/widgets/progress_dialog.dart';

class ChangePasswordController extends GetxController {
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  ProgressDialog loading = ProgressDialog();

  var hideOldPass = true.obs;
  void onOldEyeClick() {
    hideOldPass.value = !hideOldPass.value;
  }

  var hideNewPass = true.obs;
  void onNewEyeClick() {
    hideNewPass.value = !hideNewPass.value;
  }

  var hideConPass = true.obs;
  void onConEyeClick() {
    hideConPass.value = !hideConPass.value;
  }

  Future<void> onSubmit() async {
    if (formkey.currentState!.validate()) {
      loading.show();
      await AuthRepo.changePassword(
        newPassword: confirmPasswordController.text,
        oldPassword: oldPasswordController.text,
        onSuccess: (status, message) {
          if (status) {
            PetSnackBar.success(
                message: "Your password has been updated successfully.",
                title: "Password Successfully Changed! 🎉");
            Get.back();
            loading.hide();
          } else {
            loading.hide();
            PetSnackBar.error(message: message, title: "Could not change your password.");
          }
        },
      );
    }
  }
}
