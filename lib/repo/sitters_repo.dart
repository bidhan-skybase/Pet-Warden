import 'dart:convert';

import 'package:petwarden/model/appointment.dart';
import 'package:petwarden/model/sitters_model.dart';
import 'package:petwarden/utils/constants/api.dart';
import 'package:petwarden/utils/helper/log_helper.dart';
import 'package:http/http.dart' as http;
import 'package:petwarden/utils/helper/request_helper.dart';

class SittersRepo {
  static Future<void> getPetSitters({
    required Function(List<Sitters> sitters) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.getSitters;
      http.Response response = await PetRequest.get(url);
      dynamic data = json.decode(response.body);
      if (data['status']) {
        var sitters = sittersFromJson(data["data"]);
        onSuccess(sitters);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.getSitters, error: e, stackTrace: s);
      onError("Error when fetching sitters");
    }
  }

  static Future<void> getSitterDetail({
    required String id,
    required Function(Sitters sitter) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.getSitterDetail.replaceAll("#id#", id);
      http.Response response = await PetRequest.get(url);
      dynamic data = json.decode(response.body);
      if (data['status']) {
        var sitter = Sitters.fromJson(data["data"]);
        onSuccess(sitter);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.getSitterDetail, error: e, stackTrace: s);
      onError("Error when fetching sitter info");
    }
  }

  static Future<void> addReview({
    required double ratings,
    required String comment,
    required String sitterId,
    required Function(bool status) onSuccess,
    required Function(bool status) onError,
  }) async {
    try {
      String url = Api.reviewSitter;
      var body = {"rating": ratings, "comment": comment, "sitter_id": sitterId};
      http.Response response = await PetRequest.post(url, body: body);
      dynamic data = json.decode(response.body);
      if (data['status']) {
        onSuccess(true);
      } else {
        onError(false);
      }
    } catch (e, s) {
      LogHelper.error(Api.reviewSitter, error: e, stackTrace: s);
      onError(false);
    }
  }

  static Future<void> getFeaturedSitters({
    required Function(List<Sitters> sitters) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.getFeaturedSitters;
      http.Response response = await PetRequest.get(url);
      dynamic data = json.decode(response.body);
      if (data['status']) {
        var sitters = sittersFromJson(data["data"]);
        onSuccess(sitters);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.getFeaturedSitters, error: e, stackTrace: s);
      onError("Error when fetching featured sitters");
    }
  }

  static Future<void> getAppointments({
    required String monthId,
    required Function(List<Appointment> appointments) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.getAppointments.replaceAll("#id#", monthId);
      http.Response response = await PetRequest.get(url);
      dynamic data = json.decode(response.body);
      if (data['status']) {
        var appointments = appointmentsFromJson(data["data"]);
        onSuccess(appointments);
      } else {
        onError(data["message"]);
      }
    } catch (e, s) {
      LogHelper.error(Api.getFeaturedSitters, error: e, stackTrace: s);
      onError("Error when fetching appointments");
    }
  }
}
