import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/models/employee_semester.dart';
import 'package:schedualmoon/models/repository/employee_semester_services.dart';

class EmployeeSemesterController extends GetxController {
  var allEmployeesSemester = <EmployeeSemesters>[].obs;
  var isLoading = true.obs;
  var isError = false.obs;
  var departmentId;
  var semesterId;
  EmployeeSemesterController(
      {required this.departmentId, required this.semesterId});
  @override
  onInit() {
    getAllEmployeeSemesters(semesterId, departmentId);
    super.onInit();
    ever(isError, (value) {
      if (value == isError(true)) {
        Get.snackbar("internetProblem".tr, "internetDescription".tr,
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    });
  }

  //this function to non-repeate code in add days function
  addEmployeeSemesterDay(String day, String employeeSemesterId) async {
    try {
      var result = await EmployeeSemesterRepository.createEmployeeSemesterDay(
          day, employeeSemesterId);
      if (result.toString().startsWith('0000') ||
          result.toString() == 'false') {
        EasyLoading.showError('addError'.tr);
      } else if (result.toString() == "true") {
        print('entry true');
        EasyLoading.showSuccess('addDone'.tr);
        return true;
      }
    } catch (error) {
      print('error from add employee semester day: ' + error.toString());
      EasyLoading.showError('addError'.tr);
      isError(true);
    }
  }

  addDays(String day, EmployeeSemesters _employeeSemester) async {
    try {
      EasyLoading.show(status: 'wait'.tr);
      //check if employee already found or not
      //if not create  a row
      if (_employeeSemester.employeeSemesterId == -1) {
        var result = await EmployeeSemesterRepository.createEmployeeSemester(
            _employeeSemester.employeeId.toString(), semesterId, '0');
        if (result.toString().startsWith('0000') ||
            result.toString() == 'false') {
          EasyLoading.showError('addError'.tr);
        } else {
          String _employeeSemesterId = result.toString();
          allEmployeesSemester
              .where((item) => item.employeeId == _employeeSemester.employeeId)
              .toList()[0]
              .employeeSemesterId = int.parse(_employeeSemesterId);
          var resultAddDays =
              await addEmployeeSemesterDay(day, _employeeSemesterId);
          return resultAddDays;
        }
      }
      //if found only add days
      else {
        var resultAddDays = await addEmployeeSemesterDay(
            day, _employeeSemester.employeeSemesterId.toString());
        return resultAddDays;
      }
    } catch (error) {
      print('error from add days: ' + error.toString());
      isError(true);
      EasyLoading.showError('addError'.tr);
    }
  }

  getAllEmployeeSemesters(String semesterId, String departmentId) async {
    try {
      isLoading(true);
      var employeesSemester =
          await EmployeeSemesterRepository.getEmployeeSemester(
              semesterId, departmentId);
      if (employeesSemester != null) {
        allEmployeesSemester.value = employeesSemester;
      } else {
        Get.snackbar("sorry".tr, "dataEmpty".tr,
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } catch (error) {
      isError(true);
      print('error from get employees semester  ' + error.toString());
    } finally {
      isLoading(false);
    }
  }

  deleteDays(String day, EmployeeSemesters _employeeSemester) async {
    try {
      EasyLoading.show(status: 'wait'.tr);
      var result = await EmployeeSemesterRepository.deleteEmployeeSemesterDay(
          day, _employeeSemester.employeeSemesterId.toString());
      if (result.toString().startsWith('0000') ||
          result.toString() == 'false') {
        EasyLoading.showError('deleteError'.tr);
      } else if (result.toString() == "true") {
        if (day == 'السبت') {
          allEmployeesSemester
              .where((item) =>
                  item.employeeSemesterId ==
                  _employeeSemester.employeeSemesterId)
              .toList()[0]
              .days
              .sa = -1;
        } else if (day == 'الأحد') {
          allEmployeesSemester
              .where((item) =>
                  item.employeeSemesterId ==
                  _employeeSemester.employeeSemesterId)
              .toList()[0]
              .days
              .su = -1;
        } else if (day == 'الاثنين') {
          allEmployeesSemester
              .where((item) =>
                  item.employeeSemesterId ==
                  _employeeSemester.employeeSemesterId)
              .toList()[0]
              .days
              .mo = -1;
        } else if (day == 'الثلاثاء') {
          allEmployeesSemester
              .where((item) =>
                  item.employeeSemesterId ==
                  _employeeSemester.employeeSemesterId)
              .toList()[0]
              .days
              .tu = -1;
        } else if (day == 'الأربعاء') {
          allEmployeesSemester
              .where((item) =>
                  item.employeeSemesterId ==
                  _employeeSemester.employeeSemesterId)
              .toList()[0]
              .days
              .we = -1;
        }
        EasyLoading.showSuccess('deleteDone'.tr);
        return true;
      }
    } catch (error) {
      print('error from delete days: ' + error.toString());
      isError(true);
      EasyLoading.showError('deleteError'.tr);
    }
  }

  updateEmployeeSemester(String employeeSemesterId, String semesterId,
      String employeeId, String fullTime) async {
    try {
      EasyLoading.show(status: 'wait'.tr);
      var result = await EmployeeSemesterRepository.updateEmployeeSemester(
          employeeSemesterId, semesterId, employeeId, fullTime);
      if (result.toString().startsWith('0000') ||
          result.toString() == 'false') {
        print('false from server');
        EasyLoading.showError('updateError'.tr);
      } else if (result.toString() == 'true') {
        allEmployeesSemester
            .where((item) =>
                item.employeeSemesterId == int.parse(employeeSemesterId))
            .toList()[0]
            .fullTime = int.parse(fullTime);
        EasyLoading.showSuccess('updateDone'.tr);
        return true;
      }
    } catch (error) {
      print('error from update employee semester: ' + error.toString());
      isError(true);
      EasyLoading.showError('updateError'.tr);
    }
  }
}
