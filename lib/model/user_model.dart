class User {
  String? name;
  String? email;
  String? phone;
  String? status;
  String? updatedAt;
  String? createdAt;
  String? profilePicture;
  int? id;

  User({this.name, this.email, this.phone, this.status, this.updatedAt, this.createdAt, this.id});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    profilePicture = json['profile_image_url'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['status'] = status;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['profile_image_url'] = profilePicture;
    data['id'] = id;
    return data;
  }
}
