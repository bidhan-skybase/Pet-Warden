List<Sitters> sittersFromJson(List<dynamic> sittersJson) =>
    List<Sitters>.from(sittersJson.map((sitter) => Sitters.fromJson(sitter)));

class Sitters {
  String? id;
  num? avgRating;
  String? chargePerHour;
  String? experience;
  String? specialization;
  String? bio;
  String? service;
  int? userId;
  String? name;
  String? email;
  String? address;
  String? phone;
  String? status;

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
      this.status});

  Sitters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avgRating = json['avg_rating'];
    chargePerHour = json['charge_per_hour'];
    experience = json['experience'];
    specialization = json['specialization'];
    bio = json['bio'];
    service = json['service'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    phone = json['phone'];
    status = json['status'];
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
    return data;
  }
}
