class StatisticsModel {
  final Summary summary;

  StatisticsModel({required this.summary});

  factory StatisticsModel.fromJson(Map<String, dynamic> json) {
    return StatisticsModel(
      summary: Summary.fromJson(json['data']['summary']),
    );
  }
}

class Summary {
  final int totalPosts;
  final int totalLikes;
  final int totalComments;
  final int totalViews;
  final int totalEngagement;

  Summary({
    required this.totalPosts,
    required this.totalLikes,
    required this.totalComments,
    required this.totalViews,
    required this.totalEngagement,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      totalPosts: json['total_posts'] ?? 0,
      totalLikes: json['total_likes'] ?? 0,
      totalComments: json['total_comments'] ?? 0,
      totalViews: json['total_views'] ?? 0,
      totalEngagement: json['total_engagement'] ?? 0,
    );
  }
}