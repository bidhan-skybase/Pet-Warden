import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core_controller.dart';

class DashPageController extends GetxController {
  final CoreController coreController = Get.find();
  final PageController pageController = PageController();

  RxInt currentIndex = RxInt(0);

  void onPageTapped(int index) {
    if (index >= 1 && !coreController.isUserLoggedIn()) {
      pageController.jumpToPage(5);
      currentIndex.value = index;
      return;
    }

    currentIndex.value = index;
    pageController.jumpToPage(index);
  }
}
