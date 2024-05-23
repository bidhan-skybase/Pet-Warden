import 'package:petwarden/model/sitters_model.dart';

class SitterStaff {
  ExtraDetails? extraDetails;
  Staff? staff;

  SitterStaff({this.extraDetails, this.staff});

  SitterStaff.fromJson(Map<String, dynamic> json) {
    extraDetails =
        json['extra_details'] != null ? ExtraDetails.fromJson(json['extra_details']) : null;
    staff = json['staff'] != null ? Staff.fromJson(json['staff']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (extraDetails != null) {
      data['extra_details'] = extraDetails!.toJson();
    }
    if (staff != null) {
      data['staff'] = staff!.toJson();
    }
    return data;
  }
}

class ExtraDetails {
  String? staffId;
  double? avgRating;
  String? chargePerHour;
  String? experience;
  String? specialization;
  String? bio;
  String? service;
  String? status;

  ExtraDetails(
      {this.staffId,
      this.avgRating,
      this.chargePerHour,
      this.experience,
      this.specialization,
      this.bio,
      this.service,
      this.status});

  ExtraDetails.fromJson(Map<String, dynamic> json) {
    staffId = json['staff_id'];
    avgRating = double.parse(json['avg_rating'].toString());
    chargePerHour = json['charge_per_hour'];
    experience = json['experience'];
    specialization = json['specialization'];
    bio = json['bio'];
    service = json['service'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['staff_id'] = staffId;
    data['avg_rating'] = avgRating;
    data['charge_per_hour'] = chargePerHour;
    data['experience'] = experience;
    data['specialization'] = specialization;
    data['bio'] = bio;
    data['service'] = service;
    data['status'] = status;
    return data;
  }
}

class Staff {
  String? id;
  double? avgRating;
  String? chargePerHour;
  String? experience;
  String? specialization;
  String? bio;
  String? service;
  int? userId;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<Reviews>? reviews;

  Staff(
      {this.id,
      this.avgRating,
      this.chargePerHour,
      this.experience,
      this.specialization,
      this.bio,
      this.service,
      this.userId,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.reviews});

  Staff.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    avgRating = double.parse(json['avg_rating'].toString());
    chargePerHour = json['charge_per_hour'];
    experience = json['experience'].toString();
    specialization = json['specialization'];
    bio = json['bio'];
    service = json['service'];
    userId = json['user_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['avg_rating'] = avgRating;
    data['charge_per_hour'] = chargePerHour;
    data['experience'] = experience;
    data['specialization'] = specialization;
    data['bio'] = bio;
    data['service'] = service;
    data['user_id'] = userId;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
