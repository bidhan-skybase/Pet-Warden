import 'package:get/get.dart';
import 'package:petwarden/controller/booking/confirm_appointment_controller.dart';
import 'package:petwarden/view/booking/confirmation_page.dart';
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
];
