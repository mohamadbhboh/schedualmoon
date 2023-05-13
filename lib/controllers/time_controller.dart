import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/models/repository/time_services.dart';
import 'package:schedualmoon/models/time.dart';

class TimeController extends GetxController {
  var allTimes = <TimeClasses>[].obs;
  var allHours = <int>[].obs;
  //this to deal with classes in seperate
  var allBasicTime = <AllBasicTime>[].obs;
  var isLoading = true.obs;
  var isError = false.obs;
  var timeCounter = 0.obs;
  @override
  onInit() {
    getTimes();
    super.onInit();
    ever(isError, (value) {
      if (value == isError(true)) {
        Get.snackbar("internetProblem".tr, "internetDescription".tr,
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    });
  }

  assignBasicTime(int hour) {
    TimeClasses basicTime =
        allTimes.where((item) => item.hour == hour.toString()).toList()[0];
    allBasicTime.value = basicTime.allBasicTime;
  }

  getTimes() async {
    try {
      isLoading(true);
      var times = await TimeRepository.getTimes();
      if (times != null) {
        allTimes.value = times;
        var _timeClass = allTimes[0];
        timeCounter.value = int.parse(_timeClass.hour);
        assignBasicTime(timeCounter.value);
        allTimes.forEach((element) {
          allHours.add(int.parse(element.hour));
        });
      } else {
        Get.snackbar("sorry".tr, "dataEmpty.tr",
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } catch (error) {
      print('this error from time controller:' + error.toString());
      isError(true);
    } finally {
      isLoading(false);
    }
  }

  deleteTimes(String id) async {
    try {
      EasyLoading.show(status: 'wait'.tr);
      var result = await TimeRepository.deleteTime(id);

      if (result.toString().startsWith('0000') ||
          result.toString() == "false") {
        EasyLoading.showError('deleteError'.tr);
      } else if (result.toString() == "true") {
        allBasicTime.removeWhere((element) => element.id == id);
        EasyLoading.showSuccess('deleteDone'.tr);
      }
    } catch (error) {
      print(error);
      isError(true);
    } finally {
      isLoading(false);
    }
  }

  addTimes(String hour, String time) async {
    try {
      EasyLoading.show(status: 'wait'.tr);
      bool searchOnElement = false;
      //if Element already found
      if (allHours.contains(int.parse(hour))) {
        var _basics = allTimes
            .where((item) => item.hour == hour)
            .toList()[0]
            .allBasicTime;
        _basics.forEach((element) {
          if (element.time == time) {
            searchOnElement = true;
            EasyLoading.showError('alreadyFound'.tr);
          }
        });
      }
      if (searchOnElement == false) {
        //element not found already
        var result = await TimeRepository.createTime(hour, time);
        if (result.toString().startsWith('0000') ||
            result.toString() == "false") {
          EasyLoading.showError('addError'.tr);
        } else {
          AllBasicTime _newBasicTime =
              new AllBasicTime(id: result.toString(), time: time);
          //test if timeclass already found
          if (allHours.contains(int.parse(hour))) {
            TimeClasses basicTime =
                allTimes.where((item) => item.hour == hour).toList()[0];
            basicTime.allBasicTime.add(_newBasicTime);
          } else {
            List<AllBasicTime> _allBasics = <AllBasicTime>[_newBasicTime];
            TimeClasses _newTimeClasses =
                new TimeClasses(hour: hour, allBasicTime: _allBasics);
            allTimes.add(_newTimeClasses);
            allHours.add(int.parse(hour));
          }
          assignBasicTime(int.parse(hour));
          timeCounter.value = 0;
          timeCounter.value = int.parse(hour);
          EasyLoading.showSuccess('addDone'.tr);
        }
      }
    } catch (error) {
      print(error);
      isError(true);
    }
  }

  updateTime(String time, AllBasicTime item) async {
    try {
      EasyLoading.show(status: 'wait'.tr);
      var result = await TimeRepository.updateTime(time, item.id);
      if (result.toString().startsWith('0000') ||
          result.toString() == "false") {
        EasyLoading.showError('updateError'.tr);
        print('error in update' + result.toString());
      } else {
        TimeClasses basicTime = allTimes
            .where((item) => item.hour == timeCounter.value.toString())
            .toList()[0];
        basicTime.allBasicTime
            .where((element) => element.id == item.id)
            .toList()[0]
            .time = time;
        int hour = timeCounter.value;
        timeCounter.value = 0;
        timeCounter.value = hour;
        assignBasicTime(hour);
        EasyLoading.showSuccess('updateDone'.tr);
      }
    } catch (error) {
      print('an error in time controller: ' + error.toString());
      isError(true);
    }
  }
}
