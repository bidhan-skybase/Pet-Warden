import 'package:get/get.dart';
import 'package:petwarden/controller/dash_page_controller.dart';
import 'package:petwarden/controller/dash_pages/appointments_page_controller.dart';
import 'package:petwarden/controller/dash_pages/chat_page_controller.dart';
import 'package:petwarden/controller/dash_pages/home_page_controller.dart';
import 'package:petwarden/view/dash_pages/dash_screen.dart';

final List<GetPage> dashPages = <GetPage>[
  GetPage(
    name: DashPage.routeName,
    page: () => DashPage(),
    binding: BindingsBuilder(
      () {
        Get.lazyPut(() => HomePageController());
        Get.lazyPut(() => DashPageController());
        Get.lazyPut(() => ChatPageController());
        Get.lazyPut(() => AppointmentsPageController());
      },
    ),
  ),
];
