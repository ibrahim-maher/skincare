class User {
  String id;
  String name;
  String email;
  String password;
  String role;
  DateTime dateOfBirth;
  String gender;
  String phoneNumber;

  // Named constructor
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

  // Default (unnamed) constructor
  User.empty() :
        id = '',
        name = '',
        email = '',
        password = '',
        role = '',
        dateOfBirth = DateTime.now(),
        gender = '',
        phoneNumber = '';

  // Existing factory method and other parts of the class...

  // Add this toJson method
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
