import 'package:archiarena/view/orders/screen/project_details.dart';
import 'package:archiarena/view/orders/widget/project_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../core/constant/color.dart';
import '../../home/widget/custom_appbar.dart';
import '../../side_bar/professional_sidebar/sidebar_controller.dart';
import '../controller/orders_controller.dart';

class OrdersScreen extends StatelessWidget {
  final OrdersController controller = Get.put(OrdersController());
  final sideBarController = Get.find<SideBarController>();
   OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          CustomAppBar(title: 'الطلبات'),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.all(10.sp),
            child: Align(
              alignment: AlignmentGeometry.centerRight,
              child: Text(
                'المشاريع المرفوعة:', // 👈 النص المتغير
                style: TextStyle(
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.sp,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
      Obx(() => Expanded(
        child: ListView.separated(
          itemCount: controller.projects.length,
          separatorBuilder: (context, index) => SizedBox(height: 12.h), // 👈 المسافة
          itemBuilder: (context, index) {
            final project = controller.projects[index];

            return ProjectCard(
              project: project,
              onShare: () => controller.shareProject(project),
              onView: () {
                sideBarController.openProjectDetails(project);
              },
            );
          },
        ),
      )),
        ],
      ),
    );
  }
}
