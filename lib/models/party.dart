class PartyModel {
  int? id;
  String name;
  String phone;
  String role;

  PartyModel({
    this.id,
    required this.name,
    required this.phone,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {'id': id.toString(), 'name': name, 'phone': phone, 'role': role};
  }

  factory PartyModel.fromMap(Map<String, dynamic> map) {
    return PartyModel(
        id: map['id'],
        name: map['name'],
        phone: map['phone'],
        role: map['role']);
  }
}
