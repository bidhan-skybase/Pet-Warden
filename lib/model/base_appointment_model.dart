class BaseAppointment {
  String? startDate;
  String? endDate;
  String? address;
  String? emergencyContact;
  String? note;
  String? cost;
  String? staffId;
  String? petId;
  String? userEmail;

  BaseAppointment(
      {this.startDate,
      this.endDate,
      this.address,
      this.emergencyContact,
      this.note,
      this.cost,
      this.staffId,
      this.userEmail,
      this.petId});

  BaseAppointment.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
    address = json['address'];
    emergencyContact = json['emergency_contact'];
    note = json['note'];
    cost = json['cost'];
    staffId = json['staff_id'];
    userEmail = json["email"];
    petId = json['pet_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['address'] = address;
    data['emergency_contact'] = emergencyContact;
    data['note'] = note;
    data['cost'] = cost;
    data['staff_id'] = staffId;
    data['pet_id'] = petId;
    data["email"] = userEmail;
    return data;
  }
}
