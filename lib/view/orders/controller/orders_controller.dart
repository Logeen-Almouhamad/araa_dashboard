import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../model/project_model.dart';

class OrdersController extends GetxController {
  var projects = <ProjectModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProjects(); // ✅ مهم جداً
  }

  Future<void> fetchProjects() async {
    try {
      isLoading.value = true;

      // هنا تربطه بالـ API
      // final response = await api.getProjects();

      // مثال مؤقت
      projects.value = [
        ProjectModel(
          id: 1,
          title: "مشروع فيلا حديثة",
          imageUrl: "asset/images/office1.png",
          createdAt: DateTime.now().subtract(Duration(minutes: 10)),
          publisherName: 'شركة الخلف',
          publisherImage: 'asset/app_logo.png',
        ),
        ProjectModel(
          id: 2,
          title: "تصميم أعمدة سكنية داخلية",
          imageUrl: "asset/images/office2.png",
          createdAt: DateTime.now().subtract(Duration(minutes: 10)),
          publisherName: 'م.لجين',
          publisherImage: 'asset/images/user.png',
        ),
        ProjectModel(
          id: 3,
          title: "مكتب هندسي",
          imageUrl: "asset/images/office3.png",
          createdAt: DateTime.now().subtract(Duration(minutes: 10)),
          publisherName: 'م.احمد',
          publisherImage: 'asset/images/user.png',
        ),
      ];
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
