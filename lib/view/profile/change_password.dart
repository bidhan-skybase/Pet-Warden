import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petwarden/controller/profile/change_password_controller.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/utils/validators.dart';
import 'package:petwarden/widgets/custom/custom_elevated_button.dart';
import 'package:petwarden/widgets/custom/custom_password_field.dart';
import 'package:petwarden/widgets/custom/custom_text_field.dart';
import 'package:petwarden/widgets/custom/custom_text_styles.dart';

class ChangePassword extends StatelessWidget {
  static const routeName = "/change-password";
  final c = Get.find<ChangePasswordController>();
  ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: PetWardenColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: PetWardenColors.backgroundColor,
          elevation: 0,
          surfaceTintColor: PetWardenColors.backgroundColor,
          leading: InkResponse(
            radius: 20,
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 24,
              color: PetWardenColors.buttonColor,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Change Password",
                style: CustomTextStyles.f28W700(color: PetWardenColors.primaryColor),
              ),
              Text(
                "Confirm your password to change it",
                style: CustomTextStyles.f14W600(color: PetWardenColors.highlightTextColor),
              ),
              const SizedBox(
                height: 53,
              ),
              Form(
                key: c.formkey,
                child: Column(
                  children: [
                    Obx(() => CustomPasswordField(
                        hint: "Old Password",
                        eye: c.hideOldPass.value,
                        onEyeClick: c.onOldEyeClick,
                        controller: c.oldPasswordController,
                        validator: Validators.checkPasswordField,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.none)),
                    const SizedBox(
                      height: 25,
                    ),
                    Obx(() => CustomPasswordField(
                        hint: "New Password",
                        eye: c.hideNewPass.value,
                        onEyeClick: c.onNewEyeClick,
                        controller: c.newPasswordController,
                        validator: Validators.checkPasswordField,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.none)),
                    const SizedBox(
                      height: 25,
                    ),
                    Obx(() => CustomPasswordField(
                        hint: "Confirm password",
                        eye: c.hideConPass.value,
                        onEyeClick: c.onConEyeClick,
                        controller: c.confirmPasswordController,
                        validator: (value) {
                          if (value != c.newPasswordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.none)),
                    const SizedBox(
                      height: 69,
                    ),
                    CustomElevatedButton(
                      onPressed: () {
                        c.onSubmit();
                      },
                      title: "Change Password",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
