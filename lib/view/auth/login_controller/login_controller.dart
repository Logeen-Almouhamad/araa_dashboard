import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/class/status_request.dart';
import '../../../core/class/crud.dart';
import '../../../core/constant/routes.dart';
import '../../../core/services/getx_services/link.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {

  final phoneOrEmailController = TextEditingController();
  final passwordController = TextEditingController();

  final obscurePassword = true.obs;

  Crud crud = Crud();

  StatusRequest statusRequest = StatusRequest.none;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> login() async {

    print("LOGIN BUTTON PRESSED");

    final phoneOrEmail = phoneOrEmailController.text.trim();
    final password = passwordController.text;

    /// 🔵 طباعة القيم المدخلة
    print("PHONE OR EMAIL: $phoneOrEmail");
    print("PASSWORD: $password");

    if (phoneOrEmail.isEmpty || password.isEmpty) {
      Get.snackbar(
        'تنبيه',
        'يرجى إدخال الهاتف أو البريد وكلمة المرور.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    /// 🔵 طباعة الرابط
    print("SENDING REQUEST TO:");
    print(AppLink.login);

    /// 🔵 طباعة البيانات المرسلة
    print("BODY:");
    print({
      "email_or_phone": phoneOrEmail,
      "password": password,
    });

    statusRequest = StatusRequest.loading;
    update();

    final responseStatus = await crud.post(
      url: AppLink.login,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: {
        "email": phoneOrEmail,
        "password": password,
      },
      jsonEncodeBody: false,
      onSuccess: (response) async {

        print("SERVER RESPONSE:");
        print(response);

        if (response['status'] == 200 || response['success'] == true) {

          /// استخراج التوكن من الرد
          final token = response['token'];
          final userId = response['user']['id']; // 👈 استخراج user_id

          /// حفظ التوكن
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          await prefs.setInt('user_id', userId); // 👈 حفظ user_id

          print("TOKEN SAVED: $token");
          print("USER ID SAVED: $userId");


          Get.offAllNamed(AppRoutes.mainLayout);

        } else {
          Get.snackbar(
            "خطأ",
            response['message'] ?? "فشل تسجيل الدخول",
            snackPosition: SnackPosition.BOTTOM,
          );
        }

      },
    );

    print("STATUS REQUEST:");
    print(responseStatus);

    statusRequest = responseStatus;
    update();
  }

  @override
  void onClose() {
    phoneOrEmailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}