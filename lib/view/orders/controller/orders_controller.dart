import 'dart:convert';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/services/getx_services/link.dart';
import '../../../model/project_model.dart';
import '../../side_bar/professional_sidebar/sidebar_controller.dart';

class OrdersController extends GetxController {
  var projects = <ProjectModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    fetchAdminPosts();
  }



  Future<void> fetchAdminPosts() async {
    try {
      isLoading.value = true;

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      final url = Uri.parse(AppLink.posts);

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      print("STATUS CODE: ${response.statusCode}");
      print("BODY: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // 👇 حسب شكل API
        final List list = data is List ? data : data["data"];

        projects.value =
            list.map((e) => ProjectModel.fromJson(e)).toList();
      } else {
        Get.snackbar("Error", "Failed to load posts");
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }



  void shareProject(ProjectModel project) {
    // ربطه بـ share_plus لاحقاً
    print("Sharing ${project.id}");
  }

  void viewProject(ProjectModel project) {
    Get.toNamed("/project-details", arguments: project);
  }
}
