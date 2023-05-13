import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/models/repository/teaching_matrix_services.dart';
import 'package:schedualmoon/models/teachingmatrix.dart';

class TeachingMatrixController extends GetxController {
  var allTeachingMatrix = <TeachingMatrix>[].obs;
  var allTeachingMatrixSpecificEmployee = <TeachingMatrix>[].obs;
  var isLoading = true.obs;
  var isError = false.obs;
  var selectedEmployee = false.obs;

  @override
  onInit() {
    getTeachingMatrix();
    super.onInit();

    ever(isError, (value) {
      if (value == isError(true)) {
        Get.snackbar("internetProblem".tr, "internetDescription".tr,
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    });
  }

  void getTeachingMatrix() async {
    try {
      isLoading(true);
      var permessions = await TachingMatrixRepositroy.getTeachingMatrix();
      if (permessions != null) {
        allTeachingMatrix.value = permessions;
      } else {
        Get.snackbar("sorry".tr, "dataEmpty.tr",
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } catch (error) {
      print("an error is :" + error.toString());
      isError(true);
    } finally {
      isLoading(false);
    }
  }

  assignTeachingMatrix(String employeeId) async {
    allTeachingMatrixSpecificEmployee.value = allTeachingMatrix
        .where((element) => element.employeeId == employeeId)
        .toList();
  }

  addTeahingMatrix(String employeeId, String courseId) async {
    try {
      isLoading(true);
      EasyLoading.show(status: 'wait');
      var result =
          await TachingMatrixRepositroy.addTeachingMatrix(employeeId, courseId);
      if (result.toString().startsWith('0000') ||
          result.toString() == 'false') {
        EasyLoading.showError('addError'.tr);
        print('cause error: ' + result);
      } else {
        String id = result.toString();
        TeachingMatrix _newTeachingMatrix =
            TeachingMatrix(id: id, employeeId: employeeId, courseId: courseId);
        allTeachingMatrix.add(_newTeachingMatrix);
        EasyLoading.showSuccess('addDone'.tr);
      }
    } catch (error) {
      isError(true);
      print('error from add teaching matrix: ' + error.toString());
    } finally {
      isLoading(false);
    }
  }

  deleteTeachingMatrix(String id) async {
    try {
      isLoading(true);
      var result = await TachingMatrixRepositroy.deleteTeachingMatrix(id);
      if (result.toString().startsWith('0000') ||
          result.toString() == 'false') {
        EasyLoading.showError('deleteError'.tr);
        print('cause error: ' + result);
      } else if (result.toString() == "true") {
        allTeachingMatrix.removeWhere((element) => element.id == id);
        EasyLoading.showSuccess('deleteDone'.tr);
      }
    } catch (error) {
      isError(true);
      print('error from delete teaching matrix: ' + error.toString());
    } finally {
      isLoading(false);
    }
  }
}
