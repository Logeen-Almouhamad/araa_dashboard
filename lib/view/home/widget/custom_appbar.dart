import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/constant/assets.dart';
import '../../../core/constant/color.dart';
import '../home_controller/home_controller.dart';

class CustomAppBar extends StatelessWidget {
  final String title; // 👈 متغير للنص

  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          height: 100.h,
          color: AppColors.white,
          child: Row(
            children: [

              /// النص الجانبي (اختياري)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'مرحباً بك في لوحة التحكم',
                  style: TextStyle(
                    color: AppColors.teal,
                  ),
                ),
              ),

              /// هذا يجعل العنوان في المنتصف
              Expanded(
                child: Center(
                  child: Text(
                    title, // 👈 النص المتغير
                    style: TextStyle(
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 35.sp,
                    ),
                  ),
                ),
              ),

              /// حتى يبقى التوسيط مضبوط (مساحة فارغة مساوية لليسار)
              SizedBox(width: 150.w),
            ],
          ),
        ),

        /// ================= DIVIDER =================
        Container(
          width: double.infinity,
          height: 1.5.h,
          color: AppColors.primary,
        ),
      ],
    );
  }
}

