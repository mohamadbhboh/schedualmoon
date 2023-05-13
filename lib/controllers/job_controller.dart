import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/component/general_dialog.dart';
import 'package:schedualmoon/models/jobs.dart';
import 'package:schedualmoon/models/repository/job_services.dart';

class JobsController extends GetxController {
  var allJobs = <Jobs>[].obs;
  var isLoading = true.obs;
  var isError = false.obs;
  var addingItems = false.obs;
  @override
  onInit() {
    getallJobs();
    super.onInit();
    ever(isError, (value) {
      if (value == isError(true)) {
        Get.snackbar("internetProblem".tr, "internetDescription".tr,
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    });
  }

  getallJobs() async {
    try {
      isLoading(true);
      var jobs = await JobRepository.getJobs();
      if (jobs != null) {
        allJobs.value = jobs;
      } else {
        Get.snackbar("sorry".tr, "dataEmpty.tr",
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } catch (error) {
      print('an error is: ' + error.toString());
      isError(true);
    } finally {
      isLoading(false);
    }
  }

  deleteJobs(String id, BuildContext context) async {
    try {
      isLoading(true);
      var result = await JobRepository.deleteJobs(id);

      if (result.toString().startsWith('0000') ||
          result.toString() == "false") {
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
        allJobs.removeWhere((element) => element.id == id.toString());
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

  updateJob(
      Jobs item, String name, String hourDiscount, BuildContext context) async {
    try {
      isLoading(true);
      var result = await JobRepository.editJob(item.id, name, hourDiscount);
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
        item.hourDiscount = hourDiscount;
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

  addJob(BuildContext context, TextEditingController nameController,
      TextEditingController hourController) async {
    try {
      isLoading(true);
      var result =
          await JobRepository.addJob(nameController.text, hourController.text);
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
        Jobs rank = new Jobs(
            id: result.toString(),
            name: nameController.text,
            hourDiscount: hourController.text);
        allJobs.add(rank);
        nameController.text = "";
        hourController.text = "";
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
}
