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

  /// 💰 الميزانية
  final String? budget;

  /// ⏳ موعد انتهاء المشروع (String من API)
  final String? deadline;

  /// ⚡ مؤقت الصفقة (fallback كنص)
  final String? projectTimer;

  /// ⏱️ وقت انتهاء مؤقت الصفقة (DateTime)
  final DateTime? timerEndsAt;

  /// هل يوجد مؤقت صفقة
  final bool hasDealTimer;

  /// هل انتهى مؤقت الصفقة
  final bool isDealExpired;

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

    this.budget,
    this.deadline,
    this.projectTimer,
    this.timerEndsAt,

    required this.hasDealTimer,
    required this.isDealExpired,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      postId: json['post_id'],
      userId: json['user_id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      area: json['area'] ?? '',
      style: json['style'] ?? '',
      planStatus: json['plan_status'] ?? '',

      createdAt: DateTime.parse(json['created_at']),

      /// 💰
      budget: json['budget']?.toString(),

      /// ⏳
      deadline: json['deadline'],

      /// fallback
      projectTimer: json['project_timer'],

      /// ⚡
      timerEndsAt: json['timer_ends_at'] != null
          ? DateTime.tryParse(json['timer_ends_at'])
          : null,

      /// 🧠
      hasDealTimer: json['has_deal_timer'] ?? false,
      isDealExpired: json['is_deal_expired'] ?? false,
    );
  }
}