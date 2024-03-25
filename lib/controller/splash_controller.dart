import 'package:get/get.dart';
import 'package:petwarden/controller/core_controller.dart';
import 'package:petwarden/view/auth/log_in_screen.dart';

class SplashController extends GetxController {
  final CoreController coreController = Get.find<CoreController>();

  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(LogInScreen.routeName);
    });
    super.onInit();
  }
}
