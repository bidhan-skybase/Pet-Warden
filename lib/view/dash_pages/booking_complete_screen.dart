import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/utils/constants/image_paths.dart';
import 'package:petwarden/view/dash_pages/dash_screen.dart';
import 'package:petwarden/widgets/custom/custom_elevated_button.dart';
import 'package:petwarden/widgets/custom/custom_text_styles.dart';

class BookingCompleteScreen extends StatelessWidget {
  static const routeName = "/bookingComplete";
  const BookingCompleteScreen({super.key});

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
                    child: Image.asset(ImagePath.onboarding1, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  "Session Completed Successfully",
                  style: CustomTextStyles.f22W600(color: Colors.white),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    "As the Pet Sitter wraps up, we want to extend a heartfelt thank you for entrusting us with this paw-sitively delightful opportunity! ",
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
                    "Your trust means the world to us, and we're thrilled to have been part of your furry friend's adventure. Until next time, keep those tails wagging and those purrs echoing! 🐾✨",
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
