import 'dart:convert';

import 'package:petwarden/model/base_appointment_model.dart';
import 'package:petwarden/utils/constants/api.dart';
import 'package:petwarden/utils/helper/log_helper.dart';
import 'package:http/http.dart' as http;
import 'package:petwarden/utils/helper/request_helper.dart';

class BookingRepo {
  static Future<void> createAppointment(
      {required BaseAppointment appointment,
      required Function(bool status) onSuccess,
      required Function(bool status) onError}) async {
    try {
      String url = Api.addAppointment;
      var body = appointment.toJson();
      // var body = {
      //   "start_date":appointment.startDate,
      //   "end_date":appointment.endDate,
      //   "address"
      // };
      http.Response response = await PetRequest.post(url, body: body);
      dynamic data = json.decode(response.body);
      if (data["status"]) {
        onSuccess(true);
      } else {
        onError(false);
      }
    } catch (e, s) {
      LogHelper.error(Api.addAppointment, error: e, stackTrace: s);
      onError(false);
    }
  }
}
