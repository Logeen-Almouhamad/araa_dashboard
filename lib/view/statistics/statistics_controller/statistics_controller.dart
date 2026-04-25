import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/services/getx_services/link.dart';


class StatisticsController extends GetxController {

  /// loading
  RxBool isLoading = false.obs;

  /// values
  RxString viewsCount = "0".obs;
  RxString likesCount = "0".obs;
  RxString commentsCount = "0".obs;
  RxString workCount = "0".obs;

  /// progress
  RxDouble viewsProgress = 0.0.obs;
  RxDouble likesProgress = 0.0.obs;
  RxDouble commentsProgress = 0.0.obs;
  RxDouble workProgress = 0.0.obs;

  /// ================================
  /// API
  /// ================================

  Future<void> getStatistics() async {

    try {

      isLoading.value = true;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");

      final response = await http.get(
        Uri.parse(AppLink.stats),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      print("========== STATISTICS API ==========");
      print("Token: $token");
      print("Status Code: ${response.statusCode}");
      print("Response: ${response.body}");
      print("====================================");

      if (response.statusCode == 200) {

        final data = jsonDecode(response.body);

        /// طباعة JSON بعد التحويل
        print("Decoded Data: $data");

        final summary = data["data"]["summary"];

        print("Summary: $summary");

        viewsCount.value = summary["total_views"].toString();
        likesCount.value = summary["total_likes"].toString();
        commentsCount.value = summary["total_comments"].toString();
        workCount.value = summary["total_posts"].toString();

        viewsProgress.value = (summary["total_views"] ?? 0) / 100;
        likesProgress.value = (summary["total_likes"] ?? 0) / 100;
        commentsProgress.value = (summary["total_comments"] ?? 0) / 100;
        workProgress.value = (summary["total_posts"] ?? 0) / 100;
      }

    } catch (e) {

      print("Statistics Error: $e");

    } finally {

      isLoading.value = false;

    }
  }

  @override
  void onInit() {
    getStatistics();
    super.onInit();
  }
}