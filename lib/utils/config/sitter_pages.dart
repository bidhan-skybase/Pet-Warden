import 'package:get/get.dart';
import 'package:petwarden/controller/dash_pages/chat_controller.dart';
import 'package:petwarden/controller/dash_pages/profile_page_controller.dart';
import 'package:petwarden/controller/staff/appointment_controller_sitter.dart';
import 'package:petwarden/controller/staff/dash_screen_controller_sitter.dart';
import 'package:petwarden/controller/staff/login_controller_sitter.dart';
import 'package:petwarden/controller/staff/sitter_detail_controller.dart';
import 'package:petwarden/view/staff/dash_screen_sitter.dart';
import 'package:petwarden/view/staff/log_in_screen_sitter.dart';
import 'package:petwarden/view/staff/sitter_detail_screen.dart';

final List<GetPage> sitterPages = <GetPage>[
  GetPage(
      name: LoginScreenSitter.routeName,
      page: () => LoginScreenSitter(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => LoginSitterController());
      })),
  GetPage(
    name: DashScreenSitter.routeName,
    page: () => DashScreenSitter(),
    binding: BindingsBuilder(
      () {
        Get.lazyPut(() => DashScreenControllerSitter());
        Get.lazyPut(() => ChatController());
        Get.lazyPut(() => ProfilePageController());
        Get.lazyPut(() => AppointmentControllerSitter());
      },
    ),
  ),
  GetPage(
      name: SitterDetailScreen.routeName,
      page: () => SitterDetailScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SitterDetailController());
      })),
];
