class User {
  String id;
  String name;
  String email;
  String password; // Consider storing a hash instead of plain text for security.
  String role; // To distinguish between regular users, doctors, and admins.
  // Add additional fields that might be relevant to your application:
  DateTime dateOfBirth;
  String gender;
  String phoneNumber;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.dateOfBirth,
    required this.gender,
    required this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      gender: json['gender'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'gender': gender,
      'phoneNumber': phoneNumber,
    };
  }
}
