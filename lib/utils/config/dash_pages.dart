import 'package:get/get.dart';
import 'package:petwarden/controller/chat_controller.dart';
import 'package:petwarden/controller/dash_page_controller.dart';
import 'package:petwarden/controller/dash_pages/appointments_page_controller.dart';
import 'package:petwarden/controller/dash_pages/chat_page_controller.dart';
import 'package:petwarden/controller/dash_pages/home_page_controller.dart';
import 'package:petwarden/controller/dash_pages/profile_page_controller.dart';
import 'package:petwarden/controller/profile/change_password_controller.dart';
import 'package:petwarden/view/dash_pages/booking_complete_screen.dart';
import 'package:petwarden/view/dash_pages/chat_screen.dart';
import 'package:petwarden/view/dash_pages/dash_screen.dart';
import 'package:petwarden/view/dash_pages/messages_screen.dart';
import 'package:petwarden/view/dash_pages/timer_screen.dart';

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

        Get.lazyPut(() => ProfilePageController());
      },
    ),
  ),
  GetPage(
    name: TimerPage.routeName,
    page: () => const TimerPage(),
  ),
  GetPage(
    name: BookingCompleteScreen.routeName,
    page: () => const BookingCompleteScreen(),
  ),
  GetPage(
      name: MessagesScreen.routeName,
      page: () => MessagesScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MessageController());
      }))
];
