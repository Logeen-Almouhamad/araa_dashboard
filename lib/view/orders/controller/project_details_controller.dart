import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../model/project_model.dart';

class ProjectDetailsController extends GetxController {
  final ProjectModel project;
  RxList<ProjectModel> relatedProjects = <ProjectModel>[].obs;

  RxInt acceptedIndex = (-1).obs; // -1 تعني لا يوجد مشروع مقبول بعد

  ProjectDetailsController(this.project);

  @override
  void onInit() {
    fetchRelatedProjects();
    super.onInit();
  }

  void fetchRelatedProjects() async {
    // مثال API
    relatedProjects.value = [
      ProjectModel(
        id: 1,
        title: 'مشروع 1',
        imageUrl: 'asset/images/office1.png',
        createdAt: DateTime.now().subtract(Duration(minutes: 10)),
        publisherName: 'م. أحمد',
        publisherImage: 'asset/images/user.png',
      ),
      ProjectModel(
        id: 2,
        title: 'مشروع 2',
        imageUrl: 'asset/images/office2.png',
        createdAt: DateTime.now().subtract(Duration(hours: 1)),
        publisherName: 'م. لجين',
        publisherImage: 'asset/images/user.png',
      ),
      ProjectModel(
        id: 3,
        title: 'مشروع 3',
        imageUrl: 'asset/images/office3.png',
        createdAt: DateTime.now().subtract(Duration(days: 1)),
        publisherName: 'شركة الخلف',
        publisherImage: 'asset/app_logo.png',
      ),
      ProjectModel(
        id: 4,
        title: 'مشروع 4',
        imageUrl: 'asset/images/office1.png',
        createdAt: DateTime.now().subtract(Duration(days: 1)),
        publisherName: 'شركة الخلف',
        publisherImage: 'asset/app_logo.png',
      ),
      ProjectModel(
        id: 5,
        title: 'مشروع54',
        imageUrl: 'asset/images/office1.png',
        createdAt: DateTime.now().subtract(Duration(days: 1)),
        publisherName: 'م.يوسف',
        publisherImage: 'asset/app_logo.png',
      ),
      ProjectModel(
        id: 6,
        title: 'مشروع 6',
        imageUrl: 'asset/images/office1.png',
        createdAt: DateTime.now().subtract(Duration(days: 1)),
        publisherName: 'م.يوسف',
        publisherImage: 'asset/app_logo.png',
      ),
      ProjectModel(
        id: 7,
        title: 'مشروع 7',
        imageUrl: 'asset/images/office1.png',
        createdAt: DateTime.now().subtract(Duration(days: 1)),
        publisherName: 'م.يوسف',
        publisherImage: 'asset/app_logo.png',
      ),
    ];
  }

  void acceptProject(int index) {
    acceptedIndex.value = index; // ✅ فقط عدّل القيمة وليس المرجع
    Get.snackbar(
      "تم القبول",
      "تم قبول المشروع بنجاح",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}