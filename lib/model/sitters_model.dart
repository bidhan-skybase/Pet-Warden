List<Sitters> sittersFromJson(List<dynamic> sittersJson) =>
    List<Sitters>.from(sittersJson.map((sitter) => Sitters.fromJson(sitter)));

class Sitters {
  String? id;
  String? avgRating;
  String? chargePerHour;
  String? experience;
  String? specialization;
  String? bio;
  String? service;
  String? userId;
  String? name;
  String? email;
  String? address;
  String? phone;
  String? status;
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
      this.name,
      this.email,
      this.address,
      this.phone,
      this.status,
      this.reviews});

  Sitters.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    avgRating = json['avg_rating'].toString();
    chargePerHour = json['charge_per_hour'];
    experience = json['experience'];
    specialization = json['specialization'];
    bio = json['bio'];
    service = json['service'];
    userId = json['user_id'].toString();
    name = json['name'];
    email = json['email'];
    address = json['address'];
    phone = json['phone'];
    status = json['status'];
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
    data['name'] = name;
    data['email'] = email;
    data['address'] = address;
    data['phone'] = phone;
    data['status'] = status;
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reviews {
  String? id;
  String? sitterId;
  String? userId;
  int? rating;
  String? comment;
  String? createdAt;
  String? updatedAt;

  Reviews(
      {this.id,
      this.sitterId,
      this.userId,
      this.rating,
      this.comment,
      this.createdAt,
      this.updatedAt});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    sitterId = json['sitter_id'].toString();
    userId = json['user_id'].toString();
    rating = json['rating'];
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sitter_id'] = sitterId;
    data['user_id'] = userId;
    data['rating'] = rating;
    data['comment'] = comment;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
