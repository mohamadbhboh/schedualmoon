import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/component/general_dialog.dart';
import 'package:schedualmoon/models/colleges.dart';
import 'package:schedualmoon/models/repository/college_services.dart';

class CollegesController extends GetxController {
  var allColleges = <Colleges>[].obs;
  var isLoading = true.obs;
  var isError = false.obs;
  var addingItems = false.obs;

  @override
  onInit() {
    getallColleges();
    super.onInit();
    ever(isError, (value) {
      if (value == isError(true)) {
        Get.snackbar("internetProblem".tr, "internetDescription".tr,
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    });
  }

  getallColleges() async {
    try {
      isLoading(true);
      var colleges = await CollegesRepository.getColleges();
      if (colleges != null) {
        allColleges.value = colleges;
      } else {
        Get.snackbar("sorry".tr, "dataEmpty.tr",
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } catch (error) {
      print(error);
      isError(true);
    } finally {
      isLoading(false);
    }
  }

  deleteCollege(String id, BuildContext context) async {
    try {
      isLoading(true);
      var result = await CollegesRepository.deleteColleges(id);
      if (result.toString().startsWith('SQLSTATE[23000]')) {
        showDialog(
            context: context,
            builder: (context) => GeneralDialog(
                title: 'sorry'.tr,
                description: 'deleteError'.tr,
                positivePress: () {
                  Navigator.pop(context);
                },
                image: 'images/wrong.gif'));
      } else if (result.toString() == "true") {
        allColleges.removeWhere((element) => element.id == id.toString());
        showDialog(
            context: context,
            builder: (context) => GeneralDialog(
                title: 'delete'.tr,
                description: 'deleteDone'.tr,
                positivePress: () {
                  Navigator.pop(context);
                },
                image: 'images/success.gif'));
      }
    } catch (error) {
      print(error);
      isError(true);
    } finally {
      isLoading(false);
    }
  }

  addColege(String name, BuildContext context,
      TextEditingController fieldController) async {
    try {
      isLoading(true);
      var result = await CollegesRepository.addColege(name);
      if (result.toString().startsWith('0000') ||
          result.toString() == 'false') {
        showDialog(
            context: context,
            builder: (context) => GeneralDialog(
                title: 'sorry'.tr,
                description: 'addError'.tr,
                positivePress: () {
                  Navigator.pop(context);
                },
                image: 'images/wrong.gif'));
      } else {
        Colleges college = new Colleges(id: result.toString(), name: name);
        allColleges.add(college);
        fieldController.text = "";
        showDialog(
            context: context,
            builder: (context) => GeneralDialog(
                title: 'add'.tr,
                description: 'addDone'.tr,
                positivePress: () {
                  Navigator.pop(context);
                },
                image: 'images/success.gif'));
      }
    } catch (error) {
      print("an Error is : " + error.toString());
      isError(true);
    } finally {
      isLoading(false);
    }
  }

  updateCollege(Colleges item, String name, BuildContext context) async {
    try {
      isLoading(true);
      var result = await CollegesRepository.editColege(item.id, item.name);
      if (result.toString().startsWith('0000') ||
          result.toString() == 'false') {
        showDialog(
            context: context,
            builder: (context) => GeneralDialog(
                title: 'sorry'.tr,
                description: 'updateError'.tr,
                positivePress: () {
                  Navigator.pop(context);
                },
                image: 'images/wrong.gif'));
      } else {
        item.name = name;
        showDialog(
            context: context,
            builder: (context) => GeneralDialog(
                title: 'update'.tr,
                description: 'updateDone'.tr,
                positivePress: () {
                  Navigator.pop(context);
                },
                image: 'images/success.gif'));
      }
    } catch (error) {
      print("an error is: " + error.toString());
      isError(true);
    } finally {
      isLoading(false);
    }
  }
}
