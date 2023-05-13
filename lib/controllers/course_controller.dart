import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/models/courses/base_courses.dart';
import 'package:schedualmoon/models/courses/courses.dart';
import 'package:schedualmoon/models/repository/course_services.dart';

class CourseController extends GetxController {
  var allCourses = <Courses>[].obs;
  var allCoursesBackup = <Courses>[];
  var isLoading = true.obs;
  var isError = false.obs;
  var allColegeDistinct = <String>["allColleges".tr].obs;
  var allYearDistinct = <String>["allYear".tr].obs;
  var allSemesterDistinct = <String>["allSemester".tr].obs;
  static var allBaseCourses = <BaseCourses>[];
  static var isLoadingBaseCourse = true.obs;

  @override
  onInit() {
    getAllCourses();
    super.onInit();
    ever(isError, (value) {
      if (value == isError(true)) {
        Get.snackbar("internetProblem".tr, "internetDescription".tr,
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    });
  }

  //this method fill year and semester and colleges distinct
  //why this array?
  //using in filtering
  fillForFiltering() async {
    allCourses.forEach((element) {
      if (!allColegeDistinct.contains(element.departmentName)) {
        allColegeDistinct.add(element.departmentName);
      }
      if (!allYearDistinct.contains(element.year.toString())) {
        allYearDistinct.add(element.year.toString());
      }
      if (!allSemesterDistinct.contains(element.semester.toString())) {
        allSemesterDistinct.add(element.semester.toString());
      }
    });
    allYearDistinct.sort((a, b) => a.compareTo(b));
    allSemesterDistinct.sort((a, b) => a.compareTo(b));
  }

  getAllCourses() async {
    try {
      isLoading(true);
      var courses = await CoursesRepository.getCourses();
      if (courses != null) {
        allCourses.value = courses;
        allCoursesBackup = courses;
        fillForFiltering();
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

  deleteCourse(String id) async {
    try {
      isLoading(true);
      EasyLoading.show(status: 'wait'.tr);
      var result = await CoursesRepository.deleteCourse(id);
      if (result.toString().startsWith('0000') ||
          result.toString() == "false") {
        EasyLoading.showError('deleteError'.tr);
        return false;
      } else if (result.toString() == "true") {
        EasyLoading.showSuccess('deleteDone'.tr);
        return true;
      }
    } catch (error) {
      EasyLoading.showError('deleteError'.tr);
      print('error from delete controller: ' + error.toString());
    } finally {
      isLoading(false);
    }
  }

  updateCourse(String oldId, Courses item) async {
    try {
      isLoading(true);
      EasyLoading.show(status: 'wait'.tr);
      var result = await CoursesRepository.updateCourse(oldId, item);
      if (result.toString().startsWith('0000') ||
          result.toString() == 'false') {
        EasyLoading.showError('updateError'.tr);
        print('cause error: ' + result);
      } else if (result.toString() == 'true') {
        allCoursesBackup
            .where((element) => element.id == oldId)
            .toList()[0]
            .arabicName = item.arabicName;
        allCoursesBackup
            .where((element) => element.id == oldId)
            .toList()[0]
            .departmentId = item.departmentId;
        allCoursesBackup
            .where((element) => element.id == oldId)
            .toList()[0]
            .departmentName = item.departmentName;
        allCoursesBackup
            .where((element) => element.id == oldId)
            .toList()[0]
            .englishName = item.englishName;
        allCoursesBackup
            .where((element) => element.id == oldId)
            .toList()[0]
            .labHour = item.labHour;
        allCoursesBackup
            .where((element) => element.id == oldId)
            .toList()[0]
            .theoriticalHour = item.theoriticalHour;
        allCoursesBackup
            .where((element) => element.id == oldId)
            .toList()[0]
            .totalHour = item.totalHour;
        allCoursesBackup
            .where((element) => element.id == oldId)
            .toList()[0]
            .semester = item.semester;
        allCoursesBackup
            .where((element) => element.id == oldId)
            .toList()[0]
            .year = item.year;
        allCourses.where((element) => element.id == oldId).toList()[0].id =
            item.id;
        EasyLoading.showSuccess('updateDone'.tr);
      }
    } catch (error) {
      print('error from course update: ' + error.toString());
      EasyLoading.showError('updateError'.tr);
    } finally {
      isLoading(false);
    }
  }

  addCourse(Courses _newCourse) async {
    try {
      isLoading(true);
      EasyLoading.show(status: 'wait'.tr);
      var result = await CoursesRepository.addCourse(_newCourse);
      if (result.toString().startsWith('0000') ||
          result.toString() == 'false') {
        EasyLoading.showError('addError'.tr);
        print('addCourses cause error: ' + result);
      } else if (result.toString().startsWith('1111')) {
        EasyLoading.showError('alreadyUsedCourseId'.tr);
      } else if (result.toString() == "true") {
        //allCourses.add(_newCourse);
        allCoursesBackup.add(_newCourse);
        EasyLoading.showSuccess('addDone'.tr);
      }
    } catch (error) {
      print('error from add courses: ' + error.toString());
      isError(true);
      EasyLoading.showError('addError'.tr);
    } finally {
      isLoading(false);
    }
  }

  static getGraduateCourses(String departmentId) async {
    try {
      //EasyLoading.show(status: 'wait'.tr);
      var result = await CoursesRepository.getGraduateCourse(departmentId);
      if (result.toString().startsWith('0000') ||
          result.toString() == 'false') {
        EasyLoading.showError('getError'.tr);
        print('error from controller when get courses for grauate student : ' +
            result);
      } else {
        allBaseCourses = result;
      }
    } catch (error) {
      print('error from graduate courses: ' + error.toString());
      EasyLoading.showError('getError'.tr);
    } finally {
      isLoadingBaseCourse.value = false;
    }
  }
}
