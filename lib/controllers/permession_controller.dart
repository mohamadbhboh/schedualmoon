import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/models/permession.dart';
import 'package:schedualmoon/models/repository/permession_services.dart';

class PermessionController extends GetxController {
  var allPermessions = <Permession>[].obs;
  var isLoading = true.obs;
  var isError = false.obs;
  var allPermessionsBackup = <Permession>[];
  @override
  onInit() {
    getPermessions();
    super.onInit();

    ever(isError, (value) {
      if (value == isError(true)) {
        Get.snackbar("internetProblem".tr, "internetDescription".tr,
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    });
  }

  getPermessions() async {
    try {
      isLoading(true);
      var permessions = await PermessionRepository.getPermessions();
      if (permessions != null) {
        allPermessions.value = permessions;
        allPermessionsBackup = permessions;
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

  grantPermession(
    Permession permessionItem,
    String permessionId,
  ) async {
    try {
      EasyLoading.show(status: 'wait'.tr);
      var result = await PermessionRepository.grantPermssion(
          permessionItem.id, permessionId);
      if (result.toString().startsWith('0000') ||
          result.toString() == 'false') {
        EasyLoading.showError('errorGrant'.tr);
        return false;
      } else {
        EasyLoading.showSuccess('grantDone'.tr);

        return true;
      }
    } catch (error) {
      print(error);
      isError(true);
    } finally {
      EasyLoading.dismiss();
    }
  }

  revokePermession(Permession permessionItem, String permessionId) async {
    try {
      EasyLoading.show(status: 'wait'.tr);
      var result = await PermessionRepository.revokePermession(
          permessionItem.id, permessionId);
      if (result.toString().startsWith('0000') ||
          result.toString() == 'false') {
        EasyLoading.showError('errorRevoke'.tr);
        return false;
      } else {
        EasyLoading.showSuccess('revokeDone'.tr);

        return true;
      }
    } catch (error) {
      print(error);
      isError(true);
    } finally {
      EasyLoading.dismiss();
    }
  }
}
