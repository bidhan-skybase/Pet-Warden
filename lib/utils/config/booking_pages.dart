import 'package:get/get.dart';
import 'package:petwarden/controller/sitters/booking/confirm_appointment_controller.dart';
import 'package:petwarden/controller/sitters/booking/payment_controller.dart';
import 'package:petwarden/controller/sitters/pet_sitter_profile_controller.dart';
import 'package:petwarden/view/booking/appointement_success.dart';
import 'package:petwarden/view/booking/confirmation_screen.dart';
import 'package:petwarden/view/booking/payments_screen.dart';
import 'package:petwarden/view/booking/pet_sitter_profile.dart';

final List<GetPage> bookingPages = <GetPage>[
  GetPage(
    name: PetSitterProfile.routeName,
    page: () => PetSitterProfile(),
    binding: BindingsBuilder(
      () {
        Get.lazyPut(() => PetSitterProfileController());
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
    page: () => PaymentsPage(),
    binding: BindingsBuilder(
      () {
        Get.lazyPut(() => PaymentController());
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
