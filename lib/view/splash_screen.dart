import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petwarden/controller/splash_controller.dart';
import 'package:petwarden/utils/constants/colors.dart';
import 'package:petwarden/utils/constants/image_paths.dart';

import '../widgets/custom/custom_text_styles.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = "/splash-screen";
  final c = Get.find<SplashController>();
   SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PetWardenColors.primaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImagePath.logo),
              Text("Pet Warden", style: CustomTextStyles.f24W600(color: Colors.white))
            ],
          ),
        ));
  }
}
