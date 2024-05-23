List<Appointment> appointmentsFromJson(List<dynamic> appointmentsJson) => List<Appointment>.from(
    appointmentsJson.map((appointment) => Appointment.fromJson(appointment)));

class Appointment {
  String? id;
  String? startDate;
  String? endDate;
  String? timeTaken;
  String? completedAt;
  String? cancelledAt;
  String? initiatedAt;
  String? address;
  String? emergencyContact;
  String? note;
  String? status;
  double? cost;
  AppointedPet? pet;
  Owner? owner;

  Appointment(
      {this.id,
      this.startDate,
      this.endDate,
      this.timeTaken,
      this.completedAt,
      this.cancelledAt,
      this.initiatedAt,
      this.address,
      this.emergencyContact,
      this.note,
      this.status,
      this.cost,
      this.pet,
      this.owner});

  Appointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    timeTaken = json['time_taken'];
    completedAt = json['completed_at'];
    cancelledAt = json['cancelled_at'];
    initiatedAt = json['initiated_at'];
    address = json['address'];
    emergencyContact = json['emergency_contact'];
    note = json['note'];
    status = json['status'];
    cost = double.parse(json['cost'].toString());
    pet = json['pet'] != null ? AppointedPet.fromJson(json['pet']) : null;
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['time_taken'] = timeTaken;
    data['completed_at'] = completedAt;
    data['cancelled_at'] = cancelledAt;
    data['initiated_at'] = initiatedAt;
    data['address'] = address;
    data['emergency_contact'] = emergencyContact;
    data['note'] = note;
    data['status'] = status;
    data['cost'] = cost;
    if (pet != null) {
      data['pet'] = pet!.toJson();
    }
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    return data;
  }
}

class AppointedPet {
  String? id;
  String? name;
  String? age;
  String? type;
  String? breed;
  String? species;
  String? gender;
  String? vaccinationStatus;
  String? preferences;
  Owner? owner;
  String? imageUrl;

  AppointedPet(
      {this.id,
      this.name,
      this.age,
      this.type,
      this.breed,
      this.species,
      this.gender,
      this.vaccinationStatus,
      this.preferences,
      this.owner,
      this.imageUrl});

  AppointedPet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    age = json['age'];
    type = json['type'];
    breed = json['breed'];
    species = json['species'];
    gender = json['gender'];
    vaccinationStatus = json['vaccination_status'];
    preferences = json['preferences'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['age'] = age;
    data['type'] = type;
    data['breed'] = breed;
    data['species'] = species;
    data['gender'] = gender;
    data['vaccination_status'] = vaccinationStatus;
    data['preferences'] = preferences;
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    data['image_url'] = imageUrl;
    return data;
  }
}

class Owner {
  String? id;
  String? name;
  String? email;
  String? address;
  String? phone;
  String? status;
  String? role;
  String? profileImageUrl;

  Owner(
      {this.id,
      this.name,
      this.email,
      this.address,
      this.phone,
      this.status,
      this.role,
      this.profileImageUrl});

  Owner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    phone = json['phone'];
    status = json['status'];
    role = json['role'];
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
    data['role'] = role;
    data['profile_image_url'] = profileImageUrl;
    return data;
  }
}
