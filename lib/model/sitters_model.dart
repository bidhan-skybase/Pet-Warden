List<Sitters> sittersFromJson(List<dynamic> sittersJson) =>
    List<Sitters>.from(sittersJson.map((sitter) => Sitters.fromJson(sitter)));

class Sitters {
  String? id;
  double? avgRating;
  String? chargePerHour;
  String? experience;
  String? specialization;
  String? bio;
  String? service;
  String? userId;
  String? profileImageUrl;
  String? name;
  String? email;
  String? address;
  String? phone;
  String? status;
  int? reviewCount;
  int? appointmentCount;
  List<Reviews>? reviews;

  Sitters(
      {this.id,
      this.avgRating,
      this.chargePerHour,
      this.experience,
      this.specialization,
      this.bio,
      this.service,
      this.userId,
      this.profileImageUrl,
      this.name,
      this.email,
      this.address,
      this.phone,
      this.status,
      this.reviewCount,
      this.appointmentCount,
      this.reviews});

  Sitters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avgRating = double.parse(json['avg_rating'].toString());
    chargePerHour = json['charge_per_hour'];
    experience = json['experience'];
    specialization = json['specialization'];
    bio = json['bio'];
    service = json['service'];
    userId = json['user_id'].toString();
    profileImageUrl = json['profile_image_url'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    phone = json['phone'];
    status = json['status'];
    reviewCount = json['review_count'];
    appointmentCount = json['appointment_count'];
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
    data['profile_image_url'] = profileImageUrl;
    data['name'] = name;
    data['email'] = email;
    data['address'] = address;
    data['phone'] = phone;
    data['status'] = status;
    data['review_count'] = reviewCount;
    data['appointment_count'] = appointmentCount;
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reviews {
  String? id;
  String? comment;
  int? rating;
  ReviewUser? user;

  Reviews({this.id, this.comment, this.rating, this.user});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    rating = json['rating'];
    user = json['user'] != null ? ReviewUser.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['comment'] = comment;
    data['rating'] = rating;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class ReviewUser {
  String? id;
  String? name;
  String? email;
  Null address;
  String? phone;
  String? status;
  String? profileImageUrl;

  ReviewUser(
      {this.id,
      this.name,
      this.email,
      this.address,
      this.phone,
      this.status,
      this.profileImageUrl});

  ReviewUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    phone = json['phone'];
    status = json['status'];
    profileImageUrl = json['profile_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['address'] = address;
    data['phone'] = phone;
    data['status'] = status;
    data['profile_image_url'] = profileImageUrl;
    return data;
  }
}
