import 'package:get/get.dart';
import 'package:petwarden/controller/splash_controller.dart';
import 'package:petwarden/utils/config/auth_pages.dart';
import 'package:petwarden/view/splash_screen.dart';

import 'dash_pages.dart';

final List<GetPage> getPages = <GetPage>[
  ...authPages,
  ...dashPages,
  GetPage(
      name: SplashScreen.routeName,
      page: () => SplashScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SplashController());
      }))
];
