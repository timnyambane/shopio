class Party {
  String name;
  String phone;
  String role;

  Party({
    required this.name,
    required this.phone,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {'name': name, 'phone': phone, 'role': role};
  }

  factory Party.fromMap(Map<String, dynamic> map) {
    return Party(name: map['name'], phone: map['phone'], role: map['role']);
  }
}
