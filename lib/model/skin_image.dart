class SkinImage {
  String id;
  String userId;
  String imageUrl;
  String description; // A description of the skin condition.
  DateTime uploadDate;

  SkinImage({
    required this.id,
    required this.userId,
    required this.imageUrl,
    required this.description,
    required this.uploadDate,
  });

  factory SkinImage.fromJson(Map<String, dynamic> json) {
    return SkinImage(
      id: json['id'],
      userId: json['userId'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      uploadDate: DateTime.parse(json['uploadDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'imageUrl': imageUrl,
      'description': description,
      'uploadDate': uploadDate.toIso8601String(),
    };
  }
}
