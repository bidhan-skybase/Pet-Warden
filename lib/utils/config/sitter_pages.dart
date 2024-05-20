import 'package:get/get.dart';
import 'package:petwarden/controller/staff/dash_screen_controller_sitter.dart';
import 'package:petwarden/controller/staff/login_controller_sitter.dart';
import 'package:petwarden/controller/staff/chat_screen_controller_sitter.dart';
import 'package:petwarden/view/staff/dash_screen_sitter.dart';
import 'package:petwarden/view/staff/log_in_screen_sitter.dart';

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
        Get.lazyPut(() => ChatScreenControllerSitter());
      },
    ),
  ),
];
