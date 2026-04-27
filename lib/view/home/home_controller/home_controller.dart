import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../core/services/getx_services/link.dart';

class HomeController extends GetxController {

  RxInt people = 0.obs;
  RxInt companies = 0.obs;
  RxInt requests = 0.obs;
  RxList<Map<String, dynamic>> quickActions = <Map<String,dynamic>>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchHomeData();
    super.onInit();
  }

  /// جلب بيانات الهوم من السيرفر
  Future<void> fetchHomeData() async {
    isLoading.value = true;

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token == null) {
      Get.snackbar("خطأ", "لم يتم العثور على توكن المستخدم.");
      isLoading.value = false;
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(AppLink.home),
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        // جلب الإحصائيات
        people.value = body["data"]["stats"]["people"];
        companies.value = body["data"]["stats"]["companies"];
        requests.value = body["data"]["stats"]["requests"];

        // جلب الإجراءات السريعة
        quickActions.value =
        List<Map<String,dynamic>>.from(body["data"]["quick_actions"]);

      } else {
        Get.snackbar("خطأ", "فشل جلب بيانات الهوم");
      }

    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ أثناء الاتصال بالسيرفر");
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}