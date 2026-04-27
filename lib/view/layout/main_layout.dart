import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../core/constant/color.dart';
import '../add_post/add_post_screen/add_post_screen.dart';
import '../home/home_screens/home_screen.dart';
import '../orders/screen/orders_screen.dart';
import '../orders/screen/project_details.dart';
import '../side_bar/professional_sidebar/professional_sidebar.dart';
import '../side_bar/professional_sidebar/sidebar_controller.dart';
import '../statistics/statistics_screen/statistics_screen.dart';

class MainLayout extends StatelessWidget {
  MainLayout({super.key});

  // Sidebar controller ثابت
  final SideBarController sideBarController = Get.put(SideBarController());

  // كل الصفحات الممكنة
  final List<Widget> pages = [
     HomeScreen(), // الصفحة الرئيسية
     OrdersScreen(), // صفحة CheckBox
     StatisticsScreen(), // صفحة BarChart
     AddPostScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Row(
          children: [
            // المحتوى الأساسي يتغير حسب selectedIndex
            Expanded(
              child: Obx(() {
                if (sideBarController.selectedIndex.value == 1 &&
                    sideBarController.selectedProject.value != null) {
                  return ProjectDetails(
                    project: sideBarController.selectedProject.value!,
                  );
                }
                return pages[sideBarController.selectedIndex.value];
              }),
            ),

            // Sidebar ثابت على اليمين
            ProfessionalSideBar(),
          ],
        ),
      ),
    );
  }
}