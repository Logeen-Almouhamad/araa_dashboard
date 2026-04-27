import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/services/getx_services/link.dart';
import '../../../model/project_model.dart';
import '../../../model/proposal_model.dart';



class ApiHelper {
  static Future<Map<String, String>> getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    return {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };
  }
}
class ProjectDetailsController extends GetxController {
  final ProjectModel project;


  RxList<ProposalModel> proposals = <ProposalModel>[].obs;
  RxInt acceptedIndex = (-1).obs;
  RxBool isLoading = false.obs;

  ProjectDetailsController(this.project);

  @override
  void onInit() {
    fetchProposals();
    super.onInit();
  }

  Future<void> fetchProposals() async {
    try {
      isLoading.value = true;

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      final url = Uri.parse(
        "https://papayawhip-goldfish-691767.hostingersite.com/dashboard/orders/${project.id}/proposals",
      );
      print("FINAL TOKEN >>> $token");
      print("AUTH HEADER >>> Bearer $token");
      final response = await http.get(
        url,
        headers: await ApiHelper.getHeaders(),
      );
      print("TOKEN IN PROPOSALS: $token");
      print("URL: ${AppLink.getProposals(project.id)}");
      print("PROPOSALS STATUS: ${response.statusCode}");
      print("PROPOSALS BODY: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final List list = data["data"];

        proposals.value =
            list.map((e) => ProposalModel.fromJson(e)).toList();
      } else {
        Get.snackbar("Error", "Failed to load proposals");
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  /// ✅ قبول عرض
  Future<void> acceptProject(int index) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      final proposal = proposals[index];

      final url = Uri.parse(
        "https://papayawhip-goldfish-691767.hostingersite.com/home/orders/${project.id}/proposals/${proposal.id}/accept",
      );

      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token", // ✅ مهم جداً
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        acceptedIndex.value = index;

        Get.snackbar(
          "تم القبول",
          "تم قبول العرض بنجاح",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar("خطأ", "فشل القبول");
      }
    } catch (e) {
      print(e);
      Get.snackbar("خطأ", "حدث خطأ");
    }
  }
}
