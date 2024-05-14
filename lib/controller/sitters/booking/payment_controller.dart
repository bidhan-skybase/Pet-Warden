import 'package:get/get.dart';
import 'package:petwarden/model/appointment_model.dart';

class PaymentController extends GetxController {
  Appointment appointment = Appointment();
  @override
  void onInit() {
    var args = Get.arguments["appointment"];
    if (args != null) {
      appointment = args;
    }
  }
}
