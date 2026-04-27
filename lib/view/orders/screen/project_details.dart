import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../core/constant/assets.dart';
import '../../../core/constant/color.dart';
import '../../../model/project_model.dart';
import '../../../widget/gradient_button.dart';
import '../../home/widget/custom_appbar.dart';
import '../controller/project_details_controller.dart';
import '../widget/proposal_item_card.dart';

class ProjectDetails extends StatelessWidget {
  final ProjectModel project;

  const ProjectDetails({super.key, required this.project});


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProjectDetailsController(project));
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(title: 'الطلبات'),

                SizedBox(height: 20.h),

                Container(
                  decoration: BoxDecoration(
                    // color: AppColors.background,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.sp),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18.r),
                          child: Image.network(
                            project.imageUrl,
                            width: 113.w,
                            height: 85.h,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                Image.asset(Assets.office1),
                          ),
                        ),

                        SizedBox(width: 12.w),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                project.title,
                                style: TextStyle(
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryDark
                                ),
                              ),
                              SizedBox(height: 20.h,)
                            ],
                          ),
                        ),
                        Center(
                          child: ArchiButton(
                            label: "تحميل الكل",
                            icon: Icons.arrow_downward_rounded,
                            iconPosition: IconPosition.end,
                            height: 60.h,
                            fontSize: 17.sp,
                            width: 200.w,
                            borderRadius: 25,
                            onPressed: () {
                              // هنا تضيف منطق التحميل
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25.h),
                /// 🔹 Grid المشاريع

              Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.proposals.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 15.w,
                    mainAxisSpacing: 15.h,
                    childAspectRatio: 1.0,
                  ),
                  itemBuilder: (context, index) {
                    final item = controller.proposals[index];

                    return Obx(() {
                      final isAccepted = controller.acceptedIndex.value == index;
                      final isRejected = controller.acceptedIndex.value != -1 &&
                          controller.acceptedIndex.value != index;

                      return ProjectItemCard(
                        proposal: item,
                        isAccepted: controller.acceptedIndex.value == index,
                        isRejected: isRejected,
                        onAccept: () {
                          print("🔥 تم الضغط على زر القبول");
                          print("📌 index: $index");
                          controller.acceptProject(index);
                        },
                      );
                    });
                  },
                );
                    }),

              ],
            ),
          ),
        ),
      ),
    );
  }
}