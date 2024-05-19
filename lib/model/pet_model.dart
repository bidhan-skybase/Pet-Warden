class Pet {
  String? id;
  String? name;
  String? age;
  String? type;
  String? breed;
  String? species;
  String? gender;
  String? vaccinationStatus;
  String? preferences;
  String? imageUrl;
  String? ownerId;

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
      this.imageUrl,
      this.ownerId});

  Pet.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    age = json['age'];
    type = json['type'];
    breed = json['breed'];
    species = json['species'];
    gender = json['gender'];
    vaccinationStatus = json['vaccination_status'];
    preferences = json['preferences'];
    imageUrl = json['image_url'];
    ownerId = json['owner_id'].toString();
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
    data['image_url'] = imageUrl;
    data['owner_id'] = ownerId;
    return data;
  }
}
