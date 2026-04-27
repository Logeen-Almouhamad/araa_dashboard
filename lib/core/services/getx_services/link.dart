class AppLink {
  static const String appRoot =
      'https://papayawhip-goldfish-691767.hostingersite.com';

  static const String login = '$appRoot/dashboard/login';
  static const String posts = '$appRoot/dashboard/posts';
  static const String home = '$appRoot/dashboard/home';
  static const String stats = '$appRoot/dashboard/stats';
  static String getProposals(int orderId) {
    return '$appRoot/home/orders/$orderId/proposals';
  }
}