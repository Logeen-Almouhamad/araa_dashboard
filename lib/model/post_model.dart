class PostModel {
  final int postId;
  final int userId;
  final String title;
  final String description;
  final String category;
  final String area;
  final String style;
  final String planStatus;
  final DateTime createdAt;

  PostModel({
    required this.postId,
    required this.userId,
    required this.title,
    required this.description,
    required this.category,
    required this.area,
    required this.style,
    required this.planStatus,
    required this.createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      postId: json['post_id'],
      userId: json['user_id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      area: json['area'],
      style: json['style'],
      planStatus: json['plan_status'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}