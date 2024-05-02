import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petwarden/controller/auth/sign_up_controller.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/utils/constants/icon_paths.dart';
import 'package:petwarden/utils/validators.dart';
import 'package:petwarden/widgets/custom/custom_elevated_button.dart';
import 'package:petwarden/widgets/custom/custom_text_styles.dart';
import 'package:pinput/pinput.dart';

class OTPVerification extends StatelessWidget {
  final c = Get.find<SignUpController>();
  static const routeName = "/otp-verification";
  OTPVerification({super.key});

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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sign Up",
                  style: CustomTextStyles.f28W700(color: PetWardenColors.primaryColor),
                ),
                RichText(
                  text: TextSpan(
                    text: 'Verify your email for signing to  ',
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
                Center(
                  child: SvgPicture.asset(IconPath.otpImage),
                ),
                const SizedBox(
                  height: 18,
                ),
                Text(
                  "We've just sent a verification code to your email. Enter the code below to complete the sign-up process.",
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.f12W500(color: PetWardenColors.highlightTextColor),
                ),
                const SizedBox(
                  height: 55,
                ),
                Center(
                  child: Form(
                    key: c.OTPKey,
                    child: Pinput(
                      length: 5,
                      validator: Validators.checkPinField,
                      controller: c.otpController,
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      showCursor: true,
                      onCompleted: (value) {
                        c.verifyOTP();
                        // c.onSubmit();
                      },
                      defaultPinTheme: PinTheme(
                        height: 56,
                        width: 56,
                        textStyle: CustomTextStyles.f16W600(),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: PetWardenColors.borderColor),
                        ),
                      ),
                      submittedPinTheme: PinTheme(
                        height: 56,
                        width: 56,
                        textStyle: CustomTextStyles.f16W600(),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: PetWardenColors.primaryColor),
                        ),
                      ),
                      focusedPinTheme: PinTheme(
                        height: 56,
                        width: 56,
                        textStyle: CustomTextStyles.f16W600(),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: PetWardenColors.primaryColor),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 115,
                ),
                CustomElevatedButton(
                  onPressed: () {
                    c.verifyOTP();
                    // Get.toNamed(OTPVerification.routeName);
                  },
                  title: "Sign Up",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
