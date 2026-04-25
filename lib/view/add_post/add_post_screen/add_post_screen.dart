import 'dart:io';
import 'package:archiarena/view/add_post/widget/custom_post_field.dart';
import 'package:archiarena/view/home/widget/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/constant/color.dart';
import '../../../widget/gradient_button.dart';
import '../add_post_controller/add_post_controller.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddPostController());

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// العنوان
              CustomAppBar(title: 'منشور جديد'),

              SizedBox(height: 25.h),

              Text("عنوان المشروع"),
              SizedBox(height: 8.h),
              CustomPostField(
                hint: "ادخل عنوان المشروع...",
                controller: controller.titleController,
              ),

              SizedBox(height: 20.h),

              Text("الوصف"),
              SizedBox(height: 8.h),
              CustomPostField(
                hint: "ادخل وصف المشروع...",
                controller: controller.descriptionController,
                maxLines: 4,
              ),

              SizedBox(height: 20.h),

              Text("التصنيف"),
              SizedBox(height: 8.h),
              CustomPostField(
                hint: "ادخل تصنيف المشروع",
                controller: controller.categoryController,
              ),

              SizedBox(height: 25.h),

              /// الثلاث خانات الصغيرة
              Row(
                children: [
                  Expanded(
                    child: CustomPostField(
                      hint: "المساحة",
                      controller: controller.areaController,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: CustomPostField(
                      hint: "الطراز",
                      controller: controller.styleController,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: CustomPostField(
                      hint: "حالة المخطط",
                      controller: controller.planStatusController,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30.h),

              /// رفع الصورة
              Text("رفع الصورة"),
              SizedBox(height: 5.h),

              Obx(
                    () => GestureDetector(
                  onTap: controller.pickImages,
                  child: Container(
                    height: 180.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.grey300,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: controller.imagePaths.isEmpty
                        ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image, size: 40.sp, color: AppColors.teal),
                        SizedBox(height: 10.h),
                        Text("رفع الصور"),
                      ],
                    )
                        : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.imagePaths.length,
                      itemBuilder: (context, index) {
                        final path = controller.imagePaths[index];
                        return Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.all(8.w),
                              width: 160.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: Image.file(
                                  File(path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: GestureDetector(
                                onTap: () => controller.removeImage(index),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.close, color: Colors.white, size: 20.sp),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30.h),

              /// زر نشر
              Center(
                child: Obx(() {
                  final controller = Get.find<AddPostController>();
                  return controller.isLoading.value
                      ? CircularProgressIndicator(
                    color: AppColors.teal,
                  )
                      : ArchiButton(
                    label: 'نشر',
                    width: 150.w,
                    height: 50.h,
                    borderRadius: 15,
                    onPressed: () {
                      controller.submitPost();
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}