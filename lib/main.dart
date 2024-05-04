import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:petwarden/controller/core_controller.dart';
import 'package:petwarden/utils/config/pages.dart';
import 'package:petwarden/view/splash_screen.dart';

void main() async {
  await GetStorage.init();
  Get.put(CoreController());
  runApp(PetWarden());
}

class PetWarden extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final coreController = Get.find<CoreController>();
  PetWarden({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Nunito'),
      initialRoute: SplashScreen.routeName,
      getPages: getPages,
    );
  }
}
