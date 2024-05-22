import 'package:get/get.dart';
import 'package:petwarden/model/appointment_model.dart';
import 'package:petwarden/repo/booking_repo.dart';
import 'package:petwarden/repo/payment_repo.dart';
import 'package:petwarden/utils/helper/pet_snackbar.dart';
import 'package:petwarden/view/booking/appointement_success.dart';
import 'package:petwarden/view/web_view.dart';
import 'package:petwarden/widgets/progress_dialog.dart';

class PaymentController extends GetxController {
  Appointment appointment = Appointment();
  ProgressDialog loading = ProgressDialog();
  String authorization = "";
  String reference = "";
  RxBool isSelected = false.obs;

  @override
  void onInit() {
    var args = Get.arguments["appointment"];
    if (args != null) {
      appointment = args;
    }
  }

  void createAppointment() {
    loading.show(message: "Creating");
    BookingRepo.createAppointment(
        appointment: appointment,
        onSuccess: (status) {
          loading.hide();
          Get.toNamed(AppointmentSuccess.routeName);
        },
        onError: (status) {
          loading.hide();
          PetSnackBar.error(
            title: "Oh no!",
            message: "Sorry, an unexpected error occurred. 😔",
          );
          Get.back();
        });
  }

  void payWithPayStack() async {
    var a = double.parse(appointment.cost ?? "0");
    var b = a * 10.6368 * 100;
    var roundedAmount = b.ceil();
    var formattedAmount = "$roundedAmount.00";

    print(formattedAmount); // This should print: 127642.00

    loading.show(message: "Initializing");
    await PaymentRepo.payStackURLGen(
        amount: "$roundedAmount.00",
        email: appointment.userEmail ?? "",
        onSuccess: (a, r) {
          loading.hide();
          authorization = a;
          reference = r;
          Get.toNamed(BrowserView.routeName, arguments: {"url": a, "title": "Pay With Paystack"})
              ?.then((value) {
            verifyPayment();
          });
        },
        onError: (message) {
          loading.hide();
          PetSnackBar.error(message: message);
        });
  }

  void verifyPayment() async {
    loading.show(message: "Verifying");
    await PaymentRepo.verifyTransaction(
        reference: reference,
        onComplete: (status) {
          if (status == true) {
            loading.hide();
            PetSnackBar.success(
              title: "Success!",
              message: "Your payment has been verified! 🎉",
            );

            createAppointment();
          } else {
            loading.hide();
            PetSnackBar.error(
              title: "Uh-oh!",
              message: "We couldn't verify your payment. Please try again or contact support.",
            );
          }
        });
  }
}
