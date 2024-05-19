import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/utils/constants/image_paths.dart';
import 'package:petwarden/view/dash_pages/dash_screen.dart';
import 'package:petwarden/view/dash_pages/home_screen.dart';
import 'package:petwarden/widgets/custom/custom_elevated_button.dart';
import 'package:petwarden/widgets/custom/custom_text_styles.dart';

class AppointmentSuccess extends StatelessWidget {
  static const routeName = "/appointmentSuccess";
  const AppointmentSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PetWardenColors.primaryColor,
      appBar: AppBar(
        backgroundColor: PetWardenColors.primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(65),
                    child: Image.asset(ImagePath.onboarding2, fit: BoxFit.contain),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  "Appointed Successfully",
                  style: CustomTextStyles.f22W600(color: Colors.white),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    "Congratulations on finding the purr-fect Pet Sitter! Your fur baby is in good hands now!",
                    style: CustomTextStyles.f18W500(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    "Dive into the chat, stay connected, and let the pet-sitting journey begin! Your furry friend is counting on you—and their sitter—for a paw-sitively fantastic time! 🎉",
                    style: CustomTextStyles.f18W500(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 67,
                ),
                CustomElevatedButton(
                    borderSide: const BorderSide(color: Colors.white),
                    buttonColor: Colors.transparent,
                    onPressed: () {
                      Get.offAllNamed(DashPage.routeName);
                    },
                    title: "Home")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
