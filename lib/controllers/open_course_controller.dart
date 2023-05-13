import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/controllers/class_controller.dart';
import 'package:schedualmoon/models/repository/open_course_services.dart';

class OpenCourseController extends GetxController {
  var isError = false.obs;

  @override
  onInit() {
    super.onInit();
    ever(isError, (value) {
      if (value == isError(true)) {
        Get.snackbar("internetProblem".tr, "internetDescription".tr,
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    });
  }

  openCourse(String jsonCategory, ClassController classController) async {
    try {
      EasyLoading.show(status: 'wait'.tr);
      var result = await OpenCourseRepository.openCourse(jsonCategory);
      if (result.toString().startsWith('0000') ||
          result.toString() == 'false') {
        EasyLoading.showError('addError'.tr);
      } else {
        EasyLoading.showSuccess('addDone'.tr);
      }
    } catch (error) {
      EasyLoading.showError('addError'.tr);
      isError(true);
    }
  }
}
