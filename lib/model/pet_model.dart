class Pet {
  int? id;
  String? name;
  String? age;
  String? type;
  String? breed;
  String? species;
  String? gender;
  String? vaccinationStatus;
  String? preferences;
  String? profileImage;
  int? ownerId;

  Pet(
      {this.id,
      this.name,
      this.age,
      this.type,
      this.breed,
      this.species,
      this.gender,
      this.vaccinationStatus,
      this.preferences,
      this.profileImage,
      this.ownerId});

  Pet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    age = json['age'];
    type = json['type'];
    breed = json['breed'];
    species = json['species'];
    gender = json['gender'];
    vaccinationStatus = json['vaccination_status'];
    preferences = json['preferences'];
    profileImage = json['image_url_base64'];
    ownerId = json['owner_id'];
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
    data['image_url_base64'] = profileImage;
    data['owner_id'] = ownerId;
    return data;
  }
}
