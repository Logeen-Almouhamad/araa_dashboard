import 'dart:convert';
import 'dart:io';
import 'package:archiarena/core/constant/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../core/services/getx_services/link.dart';
import 'package:http_parser/http_parser.dart';

class AddPostController extends GetxController {

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();
  final areaController = TextEditingController();
  final styleController = TextEditingController();
  final planStatusController = TextEditingController();
  final daysController = TextEditingController();
  final hoursController = TextEditingController();
  final minutesController = TextEditingController();

  RxList<String> imagePaths = <String>[].obs;

  /// Loading indicator
  RxBool isLoading = false.obs;

  /// اختيار صورة واحدة أو أكثر
  Future<void> pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage();
    if (images != null && images.isNotEmpty) {
      imagePaths.addAll(images.map((e) => e.path));
    }
  }

  /// حذف صورة
  void removeImage(int index) {
    imagePaths.removeAt(index);
  }

  /// تحقق من الحقول الفارغة
  bool validateFields() {
    List<String> emptyFields = [];

    if (titleController.text.isEmpty) emptyFields.add("عنوان المشروع");
    if (descriptionController.text.isEmpty) emptyFields.add("الوصف");
    if (categoryController.text.isEmpty) emptyFields.add("التصنيف");

    if (emptyFields.isNotEmpty) {
      Get.snackbar(
        "حقول فارغة",
        "الرجاء إدخال: ${emptyFields.join(", ")}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
      );
      return false;
    }
    return true;
  }

  /// نشر البوست مع الصور
  Future<void> submitPost() async {
    if (!validateFields()) return;
    String projectTimer =
        "${daysController.text} يوم و ${hoursController.text} ساعة و ${minutesController.text} دقيقة";
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final userId = prefs.getInt("user_id");

    if (token == null || userId == null) {
      Get.snackbar("خطأ", "لم يتم العثور على بيانات المستخدم");
      return;
    }

    try {
      isLoading.value = true;

      var request = http.MultipartRequest('POST', Uri.parse(AppLink.posts));

      request.headers['Authorization'] = 'Bearer $token';

      request.fields['user_id'] = userId.toString();
      request.fields['title'] = titleController.text;
      request.fields['description'] = descriptionController.text;
      request.fields['category'] = categoryController.text;
      request.fields['area'] = areaController.text;
      request.fields['style'] = styleController.text;
      request.fields['plan_status'] = planStatusController.text;
      request.fields['project_timer'] = projectTimer;

      for (var path in imagePaths) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'images',
            path,
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      }

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      isLoading.value = false;

      try {
        var data = jsonDecode(responseBody);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Get.snackbar(
            "نجاح",
            data["message"],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.teal,
            colorText: AppColors.white,
          );

          // تفريغ الحقول بعد النشر
          titleController.clear();
          descriptionController.clear();
          categoryController.clear();
          areaController.clear();
          styleController.clear();
          planStatusController.clear();
          imagePaths.clear();
          daysController.clear();
          hoursController.clear();
          minutesController.clear();
        } else {
          Get.snackbar(
            "فشل النشر",
            data["message"] ?? "حدث خطأ أثناء نشر المنشور",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.red,
            colorText: AppColors.white,
          );
        }
      } catch (_) {
        // إذا الريسبونس ليس JSON
        Get.snackbar(
          "فشل النشر",
          "حدث خطأ أثناء نشر المنشور",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.red,
          colorText: AppColors.white,
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "خطأ",
        "حدث خطأ أثناء رفع المنشور",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      print(e);
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
    areaController.dispose();
    styleController.dispose();
    planStatusController.dispose();
    daysController.dispose();
    hoursController.dispose();
    super.onClose();
  }
}