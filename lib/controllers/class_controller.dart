import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/models/classes.dart';
import 'package:schedualmoon/models/courses/courses.dart';
import 'package:schedualmoon/models/department_teaching_matrix.dart';
import 'package:schedualmoon/models/repository/classes_services.dart';
import 'package:schedualmoon/models/teach_hour.dart';
import 'package:schedualmoon/models/teaching_matrix_menu_item.dart';

class ClassController extends GetxController {
  var allClasses = <Classes>[].obs;
  var allDepartmentCourses = <Courses>[].obs;
  var allReqiurementsCourses = <Courses>[].obs;
  var departmentCoursesNotOpening = <Courses>[].obs;
  var reqiurementsCoursesNotOpening = <Courses>[].obs;
  var allDepartmentTeachingMatrix = <DepartmentTeachingMatrix>[].obs;
  //first using for this in lab classes
  var allDepartmentsEmployee = <TeachingMatrixMenuItem>[].obs;
  var allTeachHour = <TeachHour>[].obs;
  var isLoading = true.obs;
  var isError = false.obs;
  var departmentId;
  var semesterId;

  ClassController({required this.departmentId, required this.semesterId});
  updateClasses() {
    //TODO: must remove this bad function and replcae by:
    //return last element added to database
    allClasses = <Classes>[].obs;
    allDepartmentCourses = <Courses>[].obs;
    allReqiurementsCourses = <Courses>[].obs;
    departmentCoursesNotOpening = <Courses>[].obs;
    reqiurementsCoursesNotOpening = <Courses>[].obs;
    allDepartmentTeachingMatrix = <DepartmentTeachingMatrix>[].obs;
    //first using for this in lab classes
    allDepartmentsEmployee = <TeachingMatrixMenuItem>[].obs;
    allTeachHour = <TeachHour>[].obs;
    getAllClassses(departmentId, semesterId);
    gatDeptTeachingMatrix(departmentId);
    getDepartmentEmployees(departmentId);
  }

  @override
  onInit() {
    getAllClassses(departmentId, semesterId);
    gatDeptTeachingMatrix(departmentId);
    getDepartmentEmployees(departmentId);

    super.onInit();
    ever(isError, (value) {
      if (value == isError(true)) {
        Get.snackbar("internetProblem".tr, "internetDescription".tr,
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    });
  }

  gatDeptTeachingMatrix(String departmentId) async {
    try {
      isLoading(true);
      var deptTeachingMatrix =
          await ClassRepository.readTeachingMatrix(departmentId);
      if (deptTeachingMatrix != null) {
        allDepartmentTeachingMatrix.value = deptTeachingMatrix;
      } else {
        return null;
      }
    } catch (error) {
      print('error from get teaching matrix: ' + error.toString());
      isError(true);
    } finally {
      isLoading(false);
    }
  }

  getAllClassses(String departmentId, String semesterId) async {
    try {
      isLoading(true);
      var classes = await ClassRepository.getClasses(departmentId, semesterId);
      if (classes != null) {
        allClasses.value = classes;
        var courses =
            await ClassRepository.readCoursesSpecificDepartment(departmentId);
        if (courses != null) {
          courses.forEach((element) {
            if (element.departmentId.toString() == departmentId) {
              if (allClasses
                      .where((p0) => p0.courseId == element.id)
                      .toList()
                      .length !=
                  0) {
                allDepartmentCourses.add(element);
              } else {
                departmentCoursesNotOpening.add(element);
              }
            } else {
              if (allClasses
                      .where((p0) => p0.courseId == element.id)
                      .toList()
                      .length !=
                  0) {
                allReqiurementsCourses.add(element);
              } else {
                reqiurementsCoursesNotOpening.add(element);
              }
              //get teach hour here because give 0  if i put in initstate
              getTeachHour(departmentId);
            }
          });
        } else {
          return null;
        }
      } else {
        Get.snackbar("sorry".tr, "dataEmpty.tr",
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } catch (error) {
      print('error from get classes: ' + error.toString());
      isError(true);
    } finally {
      isLoading(false);
    }
  }

  getDepartmentEmployees(String departmentId) async {
    try {
      isLoading(true);
      var deptEmployees =
          await ClassRepository.getDepartmentEmployee(departmentId);
      if (deptEmployees != null) {
        allDepartmentsEmployee.value = deptEmployees;
      } else {
        return null;
      }
    } catch (error) {
      print('error from get teaching matrix: ' + error.toString());
      isError(true);
    } finally {
      isLoading(false);
    }
  }

  getTeachHour(String departmentId) async {
    try {
      isLoading(true);
      var deptEmployees = await ClassRepository.getTeachHour(departmentId);
      if (deptEmployees != null) {
        allTeachHour.value = deptEmployees;
        //this to fill number of hour that token this teacher
        allTeachHour.forEach((element) {
          allClasses.forEach((elementClasses) {
            if (elementClasses.employeeId == element.employeeId.toString()) {
              element.hourClasses += int.parse(elementClasses.hourNumber);
            }
          });
        });
      } else {
        return null;
      }
    } catch (error) {
      print('error from get teaching matrix: ' + error.toString());
      isError(true);
    } finally {
      isLoading(false);
    }
  }
}
