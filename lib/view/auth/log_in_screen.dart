import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petwarden/controller/auth/login_controller.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/utils/validators.dart';
import 'package:petwarden/view/auth/forgot_password.dart';
import 'package:petwarden/view/auth/sign_up_screen_user.dart';
import 'package:petwarden/view/dash_pages/dash_screen.dart';
import 'package:petwarden/widgets/custom/custom_elevated_button.dart';
import 'package:petwarden/widgets/custom/custom_password_field.dart';
import 'package:petwarden/widgets/custom/custom_text_field.dart';
import 'package:petwarden/widgets/custom/custom_text_styles.dart';
import 'package:flutter/gestures.dart';

class LogInScreen extends StatelessWidget {
  static const routeName = "/login-screen";
  final c = Get.find<LoginController>();
  LogInScreen({super.key});

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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sign In",
                  style: CustomTextStyles.f28W700(color: PetWardenColors.primaryColor),
                ),
                RichText(
                  text: TextSpan(
                    text: 'Enter your credentials to login to  ',
                    style: CustomTextStyles.f14W600(color: PetWardenColors.highlightTextColor),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Pet Warden',
                          style: CustomTextStyles.f14W600(color: PetWardenColors.buttonColor)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 43,
                ),
                Form(
                  key: c.signinKey,
                  child: Column(
                    children: [
                      CustomTextField(
                          hint: "Email",
                          controller: c.emailController,
                          textInputAction: TextInputAction.next,
                          validator: Validators.checkEmailField,
                          textInputType: TextInputType.emailAddress),
                      const SizedBox(
                        height: 25,
                      ),
                      Obx(() => CustomPasswordField(
                          hint: "Password",
                          eye: c.hidePass.value,
                          onEyeClick: c.onEyeClick,
                          controller: c.passwordController,
                          validator: Validators.checkPasswordField,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.none)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      const Expanded(
                        child: SizedBox(
                          width: 10,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(ForgotPasswordScreen.routeName);
                        },
                        child: Text(
                          "Forgot Password?",
                          style: CustomTextStyles.f12W600(color: PetWardenColors.buttonColor),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomElevatedButton(
                  onPressed: () {
                    Get.toNamed(DashPage.routeName);
                  },
                  title: "Sign In",
                ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Don\'t have an account? ',
                      style: CustomTextStyles.f14W600(color: PetWardenColors.textColor),
                      children: <TextSpan>[
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.toNamed(SignUpPageUser.routeName),
                            text: 'Sign Up',
                            style: CustomTextStyles.f14W600(color: PetWardenColors.buttonColor)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
