class User {
  bool? status;
  Data? data;
  String? message;

  User({this.status, this.data, this.message});

  User.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  DateTime? emailVerifiedAt;
  String? address;
  String? phone;
  String? otp;
  DateTime? otpSentAt;
  DateTime? otpVerifiedAt;
  String? status;
  String? role;
  String? createdAt;
  String? updatedAt;

  Data({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.address,
    this.phone,
    this.otp,
    this.otpSentAt,
    this.otpVerifiedAt,
    this.status,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    address = json['address'];
    phone = json['phone'];
    otp = json['otp'];
    otpSentAt = json['otp_sent_at'];
    otpVerifiedAt = json['otp_verified_at'];
    status = json['status'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['address'] = address;
    data['phone'] = phone;
    data['otp'] = otp;
    data['otp_sent_at'] = otpSentAt;
    data['otp_verified_at'] = otpVerifiedAt;
    data['status'] = status;
    data['role'] = role;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
