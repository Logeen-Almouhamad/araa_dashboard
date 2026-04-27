import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/color.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final String value;
  final Widget icon;

  const HomeCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: Container(
        width: 307.w,
        height: 149.h,
        decoration: BoxDecoration(
          color: AppColors.background0,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.primaryDark,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 35.w,
                    height: 35.h,
                    child: icon,
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Center(
                child: Text(
                  value,
                  style: TextStyle(
                    color: AppColors.primaryDark,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

