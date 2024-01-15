class Doctor {
  String id;
  String name;
  String email;
  String specialty; // e.g., Dermatologist, Pediatrician, etc.
  List<String> qualifications; // List of degrees and certifications.
  String bio; // Short biography or description.

  Doctor({
    required this.id,
    required this.name,
    required this.email,
    required this.specialty,
    required this.qualifications,
    required this.bio,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      specialty: json['specialty'],
      qualifications: List<String>.from(json['qualifications']),
      bio: json['bio'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'specialty': specialty,
      'qualifications': qualifications,
      'bio': bio,
    };
  }
}
