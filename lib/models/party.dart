class Party {
  int? id;
  String name;
  String phone;
  String role;

  Party({
    this.id,
    required this.name,
    required this.phone,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {'id': id.toString(), 'name': name, 'phone': phone, 'role': role};
  }

  factory Party.fromMap(Map<String, dynamic> map) {
    return Party(
        id: map['id'],
        name: map['name'],
        phone: map['phone'],
        role: map['role']);
  }
}
