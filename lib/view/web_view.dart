import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:get/get.dart';
import 'package:petwarden/controller/browser_controller.dart';

class BrowserView extends StatelessWidget {
  static const String routeName = "/browser";
  final c = Get.find<BrowserController>();
  BrowserView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        if (await c.webViewController!.canGoBack()) {
          c.webViewController!.goBack();
        } else {
          return true;
        }
        return false;
      },
      child: Scaffold(
        // appBar: GearAppBar(
        //   title: c.title,
        // ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => c.progressValue.value < 1
                  ? LinearProgressIndicator(
                      minHeight: 5,
                      value: c.progressValue.value,
                      backgroundColor: theme.primaryColor.withOpacity(0.25),
                      color: theme.primaryColor,
                    )
                  : Container()),
              Expanded(
                child: InAppWebView(
                  // initialSettings: c.settings,
                  initialUrlRequest: URLRequest(url: (Uri.parse(c.url))),
                  onWebViewCreated: (controller) {
                    c.webViewController = controller;
                  },
                  onLoadStart: (controller, url) {
                    c.webViewController = controller;
                    log("Loading Started");
                  },
                  onProgressChanged: (controller, progress) {
                    c.progressValue.value = progress / 100;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
