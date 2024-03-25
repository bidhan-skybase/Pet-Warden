import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petwarden/controller/auth/forgot_password_controller.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/utils/validators.dart';
import 'package:petwarden/widgets/custom/custom_elevated_button.dart';
import 'package:petwarden/widgets/custom/custom_text_field.dart';

import '../../widgets/custom/custom_text_styles.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final c = Get.find<ForgotPasswordController>();
  static const routeName = "/forgot-password";
   ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
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
            onTap: (){
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 24,
              color: PetWardenColors.buttonColor,
            ),
          ),
        ),
        body: Padding(padding:EdgeInsets.symmetric(horizontal: 23) ,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Forgot Password",
                style: CustomTextStyles.f28W700(color: PetWardenColors.primaryColor),
              ),
            Text("Enter your mail to get a password reset link",
                style: CustomTextStyles.f14W600(color: PetWardenColors.highlightTextColor),
        ),
              const SizedBox(
                height: 53,
              ),
              Form(
                key: c.formkey,
                child: CustomTextField(
                    hint: "Email",
                    controller: c.emailController,
                    textInputAction: TextInputAction.done,
                    validator: Validators.checkEmailField,
                    textInputType: TextInputType.emailAddress),
              ),
              const SizedBox(
                height: 65,
              ),
              CustomElevatedButton(
                onPressed: () {
                  // Get.toNamed(OTPVerification.routeName);
                },
                title: "Reset Password",
              ),
          ],
        ),

        ),
      ),
    );
  }
}
