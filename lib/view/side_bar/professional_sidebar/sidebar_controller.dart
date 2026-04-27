import 'package:get/get.dart';

import '../../../model/project_model.dart';

class SideBarController extends GetxController {
  RxInt selectedIndex = 0.obs;
  var selectedProject = Rxn<ProjectModel>();
  RxInt selectedOrderId = 0.obs;
 // ProjectModel? selectedProject;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  void openProjectDetails(ProjectModel project) {
    selectedProject.value = project;
    selectedIndex.value = 1;
  }

  // 🔥 فتح الطلبات مع orderId
  void openOrders(int orderId) {
    selectedOrderId.value = orderId;
    selectedProject.value = null; // نرجع من التفاصيل
    selectedIndex.value = 1; // يفتح OrdersScreen
  }

  void backToOrders() {
    selectedProject.value = null;
  }
}
