const String baseUrl = "https://papayawhip-goldfish-691767.hostingersite.com";
class ProposalModel {
  final int id;
  final int userId;
  final String name;
  final String role;
  final String imageUrl;
  final String avatarUrl;
  final String status;
  final String message;
  final DateTime createdAt;

  ProposalModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.role,
    required this.imageUrl,
    required this.avatarUrl,
    required this.status,
    required this.message,
    required this.createdAt,
  });

  factory ProposalModel.fromJson(Map<String, dynamic> json) {
    return ProposalModel(

      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      message: json['message'] ?? '',
      status: json['status'] ?? '',

      /// ✅ صورة العرض
      imageUrl: json['image_url'] != null
          ? "https://papayawhip-goldfish-691767.hostingersite.com${json['image_url']}"
          : "",

      /// ✅ صورة المستخدم
      avatarUrl: json['avatar_url'] != null && json['avatar_url'].toString().isNotEmpty
          ? "$baseUrl${json['avatar_url']}"
          : json['profile_picture'] != null && json['profile_picture'].toString().isNotEmpty
          ? "$baseUrl${json['profile_picture']}"
          : "",

      createdAt: DateTime.parse(json['created_at']),
    );
  }
}