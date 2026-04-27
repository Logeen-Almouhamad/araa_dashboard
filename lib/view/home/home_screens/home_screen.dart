import 'package:archiarena/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constant/assets.dart';
import '../../../core/constant/color.dart';
import '../../add_post/add_post_screen/add_post_screen.dart';
import '../../orders/screen/orders_screen.dart';
import '../../side_bar/professional_sidebar/sidebar_controller.dart';
import '../home_controller/home_controller.dart';
import '../widget/custom_appbar.dart';
import '../widget/home_card.dart';
import '../widget/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          CustomAppBar(title: 'القائمة الرئيسية'),
          SizedBox(height: 10.h),
          Container(
            width: 1160.w,
            height: 255.h,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() => HomeCard(
                    title: 'الأشخاص',
                    value: controller.people.value.toString(),
                    icon: Image.asset(Assets.person, width: 35.w, height: 35.h),
                  )),
                  SizedBox(width: 6.w,),
                  Obx(() => HomeCard(
                    title: 'الشركات',
                    value: controller.companies.value.toString(),
                    icon: Image.asset(Assets.company_icon, width: 35.w, height: 35.h),
                  )),
                  SizedBox(width: 6.w,),
                  Obx(() => HomeCard(
                    title: 'الطلبات',
                    value: controller.requests.value.toString(),
                    icon: Image.asset(Assets.check_box_icon, width: 35.w, height: 35.h),
                  )),
                ],
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.all(10.sp),
            child: Align(
              alignment: AlignmentGeometry.centerRight,
              child: Text(
                'إجراءات سريعة', // 👈 النص المتغير
                style: TextStyle(
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.sp,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            width: 1160.w,
            height: 255.h,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: Padding(
                      padding: EdgeInsets.all(10.sp),
                      child: Center(
                        child:Container(
                          width: 307.w,
                          height: 149.h,
                          decoration: BoxDecoration(
                            color: AppColors.background0,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(9.sp),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center, // توسيط عمودي
                              crossAxisAlignment: CrossAxisAlignment.center, // توسيط أفقي
                              children: [
                                SizedBox(
                                  width: 35.w,
                                  height: 35.h,
                                  child: Image.asset(
                                    Assets.check_box_icon_outlined,
                                  ),
                                ),
                                SizedBox(height: 15.h),
                                Text(
                                  'مراجعة الطلبات',
                                  style: TextStyle(
                                    color: AppColors.primaryDark,
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    onTap: (){
                      final sidebarController = Get.find<SideBarController>();
                      sidebarController.changeIndex(1); // index صفحة OrdersScreen في pages[]
                    },
                  ),
                  SizedBox(width: 5.w),
                  InkWell(
                    child: Padding(
                      padding: EdgeInsets.all(10.sp),
                      child: Center(
                        child: Container(
                          width: 307.w,
                          height: 149.h,
                          decoration: BoxDecoration(
                            color: AppColors.background0,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(9.sp),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center, // توسيط عمودي
                              crossAxisAlignment: CrossAxisAlignment.center, // توسيط أفقي
                              children: [
                                SizedBox(
                                  width: 35.w,
                                  height: 35.h,
                                  child: Icon(
                                    Icons.library_add_outlined,
                                    color: AppColors.primaryDark,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  'منشور جديد',
                                  style: TextStyle(
                                    color: AppColors.primaryDark,
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ),
                    ),
                    onTap: (){
                      final sidebarController = Get.find<SideBarController>();
                      sidebarController.changeIndex(3); // index صفحة AddPostScreen في pages[]
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
