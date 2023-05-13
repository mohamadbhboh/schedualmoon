import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/models/graduate_student.dart';
import 'package:schedualmoon/models/repository/graduate_student_services.dart';

class GraduateStudentsController extends GetxController {
  var isLoading = true.obs;
  var isError = false.obs;
  var allGraduateStudent = <GraduateStudent>[].obs;
  var allGraduateStudentBackup = <GraduateStudent>[].obs;
  var departmentId;
  var semesterId;

  GraduateStudentsController(
      {required this.departmentId, required this.semesterId});

  @override
  onInit() {
    getGraduateStudent(semesterId, departmentId);
    super.onInit();
    ever(isError, (value) {
      if (value == isError(true)) {
        Get.snackbar("internetProblem".tr, "internetDescription".tr,
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    });
  }

  getGraduateStudent(String semesterId, String departmentId) async {
    try {
      isLoading(true);
      var graduateStudent = await GraduateStudentServices.getGraduateStudent(
          semesterId, departmentId);
      if (graduateStudent != null) {
        allGraduateStudent.value = graduateStudent;
        allGraduateStudentBackup.value = graduateStudent;
      } else {
        Get.snackbar("sorry".tr, "dataEmpty".tr,
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } catch (error) {
      isError(true);
      print('error from get graduate student ' + error.toString());
    } finally {
      isLoading(false);
    }
  }

  deleteGraduateQuestion(String questionId, String studentId) async {
    try {
      isLoading(true);
      EasyLoading.show(status: 'wait'.tr);
      var result = await GraduateStudentServices.deleteGraduateQuestion(
          questionId, studentId);
      if (result.toString().startsWith('0000') ||
          result.toString() == "false") {
        EasyLoading.showError('deleteError'.tr);
      } else if (result.toString() == "true") {
        EasyLoading.showSuccess('deleteDone'.tr);
        allGraduateStudent.removeWhere((element) =>
            element.questionId == questionId && element.studentId == studentId);
        allGraduateStudentBackup.removeWhere((element) =>
            element.questionId == questionId && element.studentId == studentId);
      }
    } catch (error) {
      isError(true);
      print('error from get graduate student ' + error.toString());
    } finally {
      isLoading(false);
    }
  }

  addGraduateCourse(String departmentId, String semesterId, String studentId,
      String courseId) async {
    try {} catch (error) {
      isError(true);
      print('error from add graduate course' + error.toString());
    } finally {}
  }
}
