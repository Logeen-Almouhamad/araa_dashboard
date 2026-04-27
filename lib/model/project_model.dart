class ProjectModel {
  final int id;
  final String title;
  final String imageUrl;
  final DateTime createdAt;

  final String publisherName;
  final String publisherImage;

  ProjectModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.createdAt,
    required this.publisherName,
    required this.publisherImage,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',

      // ✅ أهم تعديل (رابط الصورة)
      imageUrl: json['main_image_url'] != null
          ? "https://papayawhip-goldfish-691767.hostingersite.com${json['main_image_url']}"
          : "",

      createdAt: DateTime.parse(json['created_at']),

      publisherName: json['name'] ?? '',
      publisherImage: json['avatar_url'] != null
          ? "https://papayawhip-goldfish-691767.hostingersite.com${json['avatar_url']}"
          : "",
    );
  }
}