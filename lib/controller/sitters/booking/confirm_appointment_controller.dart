import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:intl/intl.dart';
import 'package:petwarden/model/sitters_model.dart';

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

  @override
  void onInit() {
    var args = Get.arguments["sitter"];
    if (args != null) {
      sitter.value = args;
    }
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
}
