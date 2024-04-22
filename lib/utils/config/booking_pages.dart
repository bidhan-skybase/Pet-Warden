import 'package:get/get.dart';
import 'package:petwarden/controller/booking/confirm_appointment_controller.dart';
import 'package:petwarden/view/booking/appointement_success.dart';
import 'package:petwarden/view/booking/confirmation_screen.dart';
import 'package:petwarden/view/booking/payments_screen.dart';
import 'package:petwarden/view/booking/pet_sitter_profile.dart';

final List<GetPage> bookingPages = <GetPage>[
  GetPage(
    name: PetSitterProfile.routeName,
    page: () => const PetSitterProfile(),
    binding: BindingsBuilder(
      () {
        // Get.lazyPut(() => HomePageController());
      },
    ),
  ),
  GetPage(
    name: ConfirmationPage.routeName,
    page: () => ConfirmationPage(),
    binding: BindingsBuilder(
      () {
        Get.lazyPut(() => ConfirmAppointmentController());
      },
    ),
  ),
  GetPage(
    name: PaymentsPage.routeName,
    page: () => const PaymentsPage(),
    binding: BindingsBuilder(
      () {
        Get.lazyPut(() => ConfirmAppointmentController());
      },
    ),
  ),
  GetPage(
    name: AppointmentSuccess.routeName,
    page: () => const AppointmentSuccess(),
    binding: BindingsBuilder(
      () {
        Get.lazyPut(() => ConfirmAppointmentController());
      },
    ),
  ),
];
