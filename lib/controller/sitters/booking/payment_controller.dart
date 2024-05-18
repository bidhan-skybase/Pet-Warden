import 'package:get/get.dart';
import 'package:petwarden/model/appointment_model.dart';
import 'package:petwarden/repo/booking_repo.dart';
import 'package:petwarden/utils/helper/pet_snackbar.dart';
import 'package:petwarden/view/booking/appointement_success.dart';

class PaymentController extends GetxController {
  Appointment appointment = Appointment();
  @override
  void onInit() {
    var args = Get.arguments["appointment"];
    if (args != null) {
      appointment = args;
    }
  }

  void createAppointment() {
    BookingRepo.createAppointment(
        appointment: appointment,
        onSuccess: (status) {
          Get.toNamed(AppointmentSuccess.routeName);
        },
        onError: (status) {
          PetSnackBar.error(
            title: "Oh no!",
            message: "Sorry, an unexpected error occurred. 😔",
          );
          Get.back();
        });
  }
}
