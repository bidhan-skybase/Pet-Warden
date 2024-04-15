import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ConfirmAppointmentController extends GetxController {
  Rx           startingTime = "".obs;
  RxString endingTime = "".obs;
  var addressController = TextEditingController();
  var contactController = TextEditingController();
  var noteController = TextEditingController();

  String formatDateTime(DateTime dateTime) {
    return DateFormat('E, dd MMMM yyyy hh:mm a').format(dateTime);
  }
}
