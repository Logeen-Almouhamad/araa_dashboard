import 'package:archiarena/core/constant/assets.dart';
import 'package:archiarena/core/constant/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../model/project_model.dart';
import '../../../widget/gradient_button.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final VoidCallback onShare;
  final VoidCallback onView;

  const ProjectCard({
    super.key,
    required this.project,
    required this.onShare,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.h,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Row(
          children: [
            /// الصورة ديناميكية
            ClipRRect(
              borderRadius: BorderRadius.circular(18.r),
              child: Image.network(
                project.imageUrl, // من الباك إند
                width: 113.w,
                height: 85.h,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Image.asset(Assets.office1),
              ),
            ),

            SizedBox(width: 12.w),

            /// النصوص والأزرار
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// عنوان المشروع
                    Text(
                      project.title,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 4.h),

                    /// الوقت
                    Text(
                      timeAgo(project.createdAt),
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.grey700,
                      ),
                    ),

                    const Spacer(),
                  ],
                ),
              ),
            ),
            /// الأزرار
            Row(
              children: [
                ArchiButton(
                  label: "مشاركة",
                  icon: Icons.share,
                  iconPosition: IconPosition.end,
                  height: 60.h,
                  fontSize: 17.sp,
                  width: 130.w,
                  borderRadius: 25,
                  onPressed: onShare,
                ),
                SizedBox(width: 8.w),
                ArchiButton(
                  label: "عرض",
                  height: 60.h,
                  fontSize: 19.sp,
                  width: 130.w,
                  borderRadius: 25,
                  onPressed: onView,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
//time formatter (منذ دقيقة - منذ ساعتين - منذ يومين)
  String timeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);

    if (difference.inMinutes < 1) {
      return "الآن";
    } else if (difference.inMinutes < 60) {
      return "منذ ${difference.inMinutes} دقيقة";
    } else if (difference.inHours < 24) {
      return "منذ ${difference.inHours} ساعة";
    } else {
      return "منذ ${difference.inDays} يوم";
    }
  }
}





