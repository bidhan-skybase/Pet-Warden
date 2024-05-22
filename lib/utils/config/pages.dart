import 'package:get/get.dart';
import 'package:petwarden/controller/browser_controller.dart';
import 'package:petwarden/controller/splash_controller.dart';
import 'package:petwarden/utils/config/auth_pages.dart';
import 'package:petwarden/utils/config/booking_pages.dart';
import 'package:petwarden/utils/config/profile_pages.dart';
import 'package:petwarden/utils/config/sitter_pages.dart';
import 'package:petwarden/view/on_boarding_screen.dart';
import 'package:petwarden/view/splash_screen.dart';
import 'package:petwarden/view/web_view.dart';

import 'dash_pages.dart';

final List<GetPage> getPages = <GetPage>[
  ...authPages,
  ...dashPages,
  ...bookingPages,
  ...profilePages,
  ...sitterPages,
  GetPage(
      name: SplashScreen.routeName,
      page: () => SplashScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SplashController());
      })),
  GetPage(
      name: OnboardingPage.routeName,
      page: () => const OnboardingPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SplashController());
      })),
  GetPage(
      name: BrowserView.routeName,
      page: () => BrowserView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => BrowserController());
      }))
];
