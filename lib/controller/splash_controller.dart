import 'dart:async';
import 'package:get/get.dart';
import 'package:petwarden/controller/core_controller.dart';
import 'package:petwarden/view/auth/log_in_screen.dart';
import 'package:petwarden/view/dash_pages/dash_screen.dart';
import 'package:petwarden/view/on_boarding_screen.dart';
import 'package:petwarden/view/staff/dash_screen_sitter.dart';

class SplashController extends GetxController {
  final CoreController coreController = Get.find();

  @override
  void onInit() async {
    Timer(const Duration(seconds: 3), () {
      if (coreController.isOnboarded() == false) {
        Get.offAllNamed(OnboardingPage.routeName);
      } else if (coreController.isUserLoggedIn()) {
        if (coreController.userType == USERTYPE.OWNER) {
          Get.offAllNamed(DashPage.routeName);
        } else {
          Get.offAllNamed(DashScreenSitter.routeName);
        }
      } else {
        Get.offAllNamed(LogInScreen.routeName);
      }
    });
    super.onInit();
  }
}
