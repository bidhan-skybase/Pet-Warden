import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class BrowserController extends GetxController {
  final GlobalKey werbViewKey = GlobalKey();
  RxDouble progressValue = RxDouble(0);
  RxBool showBack = RxBool(false);

  String url = "";
  String title = "";

  InAppWebViewController? webViewController;
  // InAppWebViewSettings settings=InAppWebViewSettings(
  //   userAgent: "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36",
  //   applicationNameForUserAgent: "GearChecker",
  // );

  @override
  void onInit() {
    var arguments = Get.arguments;
    if (arguments != null) {
      url = arguments['url'];
      title = arguments['title'];
    }
    super.onInit();
  }
}
