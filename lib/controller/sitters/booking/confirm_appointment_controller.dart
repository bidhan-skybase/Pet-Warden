import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:intl/intl.dart';
import 'package:petwarden/controller/core_controller.dart';
import 'package:petwarden/model/base_appointment_model.dart';
import 'package:petwarden/model/pet_model.dart';
import 'package:petwarden/model/sitters_model.dart';
import 'package:petwarden/view/booking/payments_screen.dart';

class ConfirmAppointmentController extends GetxController {
  DateTime start = DateTime.now();
  DateTime end = DateTime.now();
  RxString startingTime = "".obs;
  RxString endingTime = "".obs;
  var addressController = TextEditingController();
  var contactController = TextEditingController();
  var noteController = TextEditingController();
  RxDouble total = 0.0.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rxn<Sitters> sitter = Rxn();
  var cc = Get.find<CoreController>();
  RxList<Pet> pets = <Pet>[].obs;
  RxString petId = "".obs;

  @override
  void onInit() {
    var args = Get.arguments["sitter"];
    if (args != null) {
      sitter.value = args;
    }
    pets = cc.pets;
    super.onInit();
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('E, dd MMMM yyyy hh:mm a').format(dateTime);
  }

  calculatePrice() {
    if (start.isBefore(end)) {
      var duration = end.difference(start);
      total.value = duration.inHours * double.parse(sitter.value!.chargePerHour ?? "0.0");
    }
  }

  void onSubmit() {
    BaseAppointment appointment = BaseAppointment(
        startDate: startingTime.value,
        endDate: endingTime.value,
        address: addressController.text,
        emergencyContact: contactController.text,
        note: noteController.text,
        cost: total.string,
        staffId: sitter.value!.id.toString(),
        petId: petId.value,
        userEmail: cc.currentUser.value?.email ?? "");
    // petId: cc.currentPet.value!.id.toString());
    Get.toNamed(PaymentsPage.routeName, arguments: {"appointment": appointment});
  }
}
