import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/component/general_dialog.dart';
import 'package:schedualmoon/models/ranks.dart';
import 'package:schedualmoon/models/repository/rank_services.dart';

class RankController extends GetxController {
  var allRanks = <Ranks>[].obs;
  var isLoading = true.obs;
  var isError = false.obs;
  var addingItems = false.obs;

  @override
  onInit() {
    getRanks();
    super.onInit();

    ever(isError, (value) {
      if (value == isError(true)) {
        Get.snackbar("internetProblem".tr, "internetDescription".tr,
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    });
  }

  getRanks() async {
    try {
      isLoading(true);
      var ranks = await RankRepository.getRanks();
      if (ranks != null) {
        allRanks.value = ranks;
      } else {
        Get.snackbar("sorry".tr, "dataEmpty.tr",
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } catch (error) {
      print('this error from rank controller: ' + error.toString());
      isError(true);
    } finally {
      isLoading(false);
    }
  }

  deleteRank(String id, BuildContext context) async {
    try {
      isLoading(true);
      var result = await RankRepository.deleteRank(id);

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
        allRanks.removeWhere((element) => element.id == id.toString());
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

  updateRank(
      Ranks item, String name, String hourNumber, BuildContext context) async {
    try {
      isLoading(true);
      var result = await RankRepository.editRank(item.id, name, hourNumber);
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
        item.hourNumber = hourNumber;
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

  addRank(BuildContext context, TextEditingController nameController,
      TextEditingController hourController) async {
    try {
      isLoading(true);
      var result = await RankRepository.addRank(
          nameController.text, hourController.text);
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
        Ranks rank = new Ranks(
            id: result.toString(),
            name: nameController.text,
            hourNumber: hourController.text);
        allRanks.add(rank);
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
