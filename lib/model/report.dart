class Report {
  String id;
  String userId;
  String doctorId;
  String diagnosis;
  List<String> images; // List of image URLs.
  String comments;
  DateTime creationDate;
  DateTime lastUpdatedDate;
  String status; // e.g., Pending, Confirmed, Reviewed.

  Report({
    required this.id,
    required this.userId,
    required this.doctorId,
    required this.diagnosis,
    required this.images,
    required this.comments,
    required this.creationDate,
    required this.lastUpdatedDate,
    required this.status,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'],
      userId: json['userId'],
      doctorId: json['doctorId'],
      diagnosis: json['diagnosis'],
      images: List<String>.from(json['images']),
      comments: json['comments'],
      creationDate: DateTime.parse(json['creationDate']),
      lastUpdatedDate: DateTime.parse(json['lastUpdatedDate']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'doctorId': doctorId,
      'diagnosis': diagnosis,
      'images': images,
      'comments': comments,
      'creationDate': creationDate.toIso8601String(),
      'lastUpdatedDate': lastUpdatedDate.toIso8601String(),
      'status': status,
    };
  }
}
