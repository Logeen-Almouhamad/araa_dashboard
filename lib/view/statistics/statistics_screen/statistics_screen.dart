import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constant/color.dart';
import '../../home/widget/custom_appbar.dart';
import '../statistics_controller/statistics_controller.dart';
import '../widget/stats_progress_row.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(StatisticsController());

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          CustomAppBar(title: "الإحصائيات"),

          SizedBox(height: 20.h),

          /// ===== نظرة عامة =====
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              "نظرة عامة هذا الشهر",
              style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDark,
              ),
            ),
          ),

          SizedBox(height: 15.h),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            padding: EdgeInsets.all(20.sp),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Obx(() {

              if(controller.isLoading.value){
                return const Center(child: CircularProgressIndicator());
              }

              return StatsProgressRow(
                title: "المشاهدات",
                value: controller.viewsCount.value,
                progress: controller.viewsProgress.value,
              );

            }),
          ),

          SizedBox(height: 25.h),

          /// ===== التفاعلات =====
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              "التفاعلات",
              style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDark,
              ),
            ),
          ),

          SizedBox(height: 15.h),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            padding: EdgeInsets.all(20.sp),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Obx(() => Column(
              children: [
                StatsProgressRow(
                  title: "الإعجابات",
                  value: controller.likesCount.value,
                  progress: controller.likesProgress.value,
                ),
                SizedBox(height: 20.h),
                StatsProgressRow(
                  title: "التعليقات",
                  value: controller.commentsCount.value,
                  progress: controller.commentsProgress.value,
                ),
                SizedBox(height: 20.h),
                StatsProgressRow(
                  title: "البدء بالعمل",
                  value: controller.workCount.value,
                  progress: controller.workProgress.value,
                ),
              ],
            )),
          ),

        ],
      ),
    );
  }
}