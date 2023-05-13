import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/models/repository/student_services.dart';
import 'package:schedualmoon/models/students.dart';

class StudentController extends GetxController {
  var allStudents = <Students>[];
  var isLoading = false.obs;
  var isError = false.obs;
  String departmentId;

  StudentController({required this.departmentId});
  @override
  onInit() {
    getGraduateStudent();
    super.onInit();

    ever(isError, (value) {
      if (value == isError(true)) {
        Get.snackbar("internetProblem".tr, "internetDescription".tr,
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    });
  }

  void getGraduateStudent() async {
    try {
      isLoading(true);
      var students = await StudentServices.getGraduateStudent(departmentId);
      if (students != null) {
        allStudents = students;
      } else {
        Get.snackbar("sorry".tr, "dataEmpty.tr",
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } catch (error) {
      isError(true);
      print('error from get semesters: ' + error.toString());
    } finally {
      isLoading(false);
    }
  }
}
