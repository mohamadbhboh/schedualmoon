import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/models/repository/semester_services.dart';
import 'package:schedualmoon/models/semester.dart';

class SemesterController extends GetxController {
  var allSemesters = <Semesters>[].obs;
  var isLoading = false.obs;
  var isError = false.obs;
  @override
  onInit() {
    getSemesters();
    super.onInit();

    ever(isError, (value) {
      if (value == isError(true)) {
        Get.snackbar("internetProblem".tr, "internetDescription".tr,
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    });
  }

  void getSemesters() async {
    try {
      isLoading(true);
      var semesters = await SemesterRepository.getSemesters();
      if (semesters != null) {
        allSemesters.value = semesters;
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

  updateSemester(String id, String _semester, String _year) async {
    try {
      isLoading(true);
      var result = await SemesterRepository.editSemester(id, _semester, _year);
      if (result.toString().startsWith('0000') ||
          result.toString() == 'false') {
        EasyLoading.showError('updateError');
      } else if (result.toString() == "true") {
        allSemesters.where((element) => element.id == id).toList()[0].semester =
            _semester;
        allSemesters.where((element) => element.id == id).toList()[0].year =
            _year;
        EasyLoading.showSuccess('updateDone'.tr);
      }
    } catch (error) {
      isError(true);
      print('error from updateSemester: ' + error.toString());
    } finally {
      isLoading(false);
    }
  }

  deleteSemester(String id) async {
    try {
      isLoading(true);
      var result = await SemesterRepository.deleteSemester(id);
      if (result.toString().startsWith('0000') ||
          result.toString() == 'false') {
        EasyLoading.showError('deleteError'.tr);
      } else if (result.toString() == "true") {
        allSemesters.removeWhere((element) => element.id == id);
        EasyLoading.showSuccess('deleteDone'.tr);
      }
    } catch (error) {
      isError(true);
      print('error from delete semester: ' + error.toString());
    } finally {
      isLoading(false);
    }
  }

  addSemester(String _year, String _semester) async {
    try {
      isLoading(true);
      EasyLoading.show(status: 'wait'.tr);
      var result = await SemesterRepository.addSemester(_semester, _year);
      if (result.toString().startsWith('0000') ||
          result.toString() == 'false') {
        EasyLoading.showError('addError'.tr);
        print('addCourses cause error: ' + result);
      } else {
        Semesters _newsemester =
            Semesters(id: result.toString(), semester: _semester, year: _year);
        allSemesters.add(_newsemester);
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
}
