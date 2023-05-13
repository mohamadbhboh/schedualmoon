import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/models/departments.dart';
import 'package:schedualmoon/models/repository/department_services.dart';

class DepartmentController extends GetxController {
  var allDepartments = <Departments>[].obs;
  var allDepartmentsBackup = <Departments>[];
  var isLoading = true.obs;
  var isError = false.obs;
  @override
  onInit() {
    getAllDepartments();
    super.onInit();
    ever(isError, (value) {
      if (value == isError(true)) {
        Get.snackbar("internetProblem".tr, "internetDescription".tr,
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    });
  }

  getAllDepartments() async {
    try {
      isLoading(true);
      var departments = await DepartmentRepository.getDepartments();
      if (departments != null) {
        allDepartments.value = departments;
        allDepartmentsBackup = departments;
      } else {
        Get.snackbar("sorry".tr, "dataEmpty.tr",
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } catch (error) {
      print('error from course controller , get: ' + error.toString());
      isError(true);
    } finally {
      isLoading(false);
    }
  }

  addDepartment(String name, String collegeId, String collegeName) async {
    try {
      isLoading(true);
      EasyLoading.show(status: 'wait'.tr);
      var result = await DepartmentRepository.addDepartments(name, collegeId);
      if (result.toString().startsWith('0000') ||
          result.toString() == 'false') {
        EasyLoading.showError('addError'.tr);
        print('addCourses cause error: ' + result);
      } else {
        int maxId = int.parse(result.toString());
        Departments _department = Departments(
            id: maxId,
            collegeId: int.parse(collegeId),
            name: name,
            collegeName: collegeName);
        allDepartments.add(_department);
        EasyLoading.showSuccess('addDone'.tr);
      }
    } catch (error) {
      EasyLoading.showError('addError'.tr);
      print('error from add department: ' + error.toString());
      isError(true);
    } finally {
      isLoading(false);
    }
  }

  deleteDepartment(int departmentId) async {
    try {
      EasyLoading.show(status: 'wait'.tr);
      isLoading(true);
      var result = await DepartmentRepository.deleteDepartment(departmentId);
      if (result.toString().startsWith('0000') ||
          result.toString() == 'false') {
        EasyLoading.showError('deleteError'.tr);
      } else {
        allDepartments.removeWhere((element) => element.id == departmentId);
        allDepartmentsBackup
            .removeWhere((element) => element.id == departmentId);
        EasyLoading.showSuccess('deleteDone'.tr);
      }
    } catch (error) {
      isError(true);
      print('error from delete department: ' + error.toString());
    } finally {
      isLoading(false);
    }
  }

  updateDepartment(int departmentId, String departmentName, String collegeId,
      String collegeName) async {
    try {
      EasyLoading.show(status: 'wait'.tr);
      isLoading(true);
      var result = await DepartmentRepository.updateDepartment(
          departmentId, departmentName, collegeId);
      if (result.toString().startsWith('0000') ||
          result.toString() == 'false') {
        EasyLoading.showError('updateError'.tr);
      } else {
        allDepartments
            .where((element) => element.id == departmentId)
            .toList()[0]
            .collegeName = collegeName;
        allDepartments
            .where((element) => element.id == departmentId)
            .toList()[0]
            .collegeId = int.parse(collegeId);
        allDepartments
            .where((element) => element.id == departmentId)
            .toList()[0]
            .name = departmentName;
        EasyLoading.showSuccess('updateDone'.tr);
      }
    } catch (error) {
      isError(true);
      print('error from update department: ' + error.toString());
    } finally {
      isLoading(false);
    }
  }
}
