import 'package:petwarden/model/sitters_model.dart';

class SitterStaff {
  String? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? address;
  String? phone;
  String? profileImageUrl;
  String? status;
  String? role;
  String? createdAt;
  String? updatedAt;
  ExtraDetails? extraDetails;
  Staff? staff;

  SitterStaff(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.address,
      this.phone,
      this.profileImageUrl,
      this.status,
      this.role,
      this.createdAt,
      this.updatedAt,
      this.extraDetails,
      this.staff});

  SitterStaff.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    address = json['address'];
    phone = json['phone'];
    profileImageUrl = json['profile_image_url'];
    status = json['status'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    extraDetails =
        json['extra_details'] != null ? ExtraDetails.fromJson(json['extra_details']) : null;
    staff = json['staff'] != null ? Staff.fromJson(json['staff']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['address'] = address;
    data['phone'] = phone;
    data['profile_image_url'] = profileImageUrl;

    data['status'] = status;
    data['role'] = role;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
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
    avgRating = json['avg_rating'];
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
    avgRating = json['avg_rating'];
    chargePerHour = json['charge_per_hour'];
    experience = json['experience'];
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
