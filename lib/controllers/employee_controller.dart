import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/component/general_dialog.dart';
import 'package:schedualmoon/models/employees.dart';
import 'package:schedualmoon/models/jobRankDepartmentmodel.dart';
import 'package:schedualmoon/models/repository/employee_services.dart';
import 'package:schedualmoon/models/repository/jobRankDepartmentModel_services.dart';
//import 'package:schedualmoon/view/addEmployee_view.dart';

class EmployeesController extends GetxController {
  var allEmploees = <Employees>[].obs;
  var isLoading = true.obs;
  var isError = false.obs;
  late JobRankDepartmentModel allJobRankDepartments;
  List<Employees> employeesBackup = [];

  @override
  onInit() {
    getallEmployees();
    getJobsWithRankAndDepartment();
    super.onInit();
    ever(isError, (value) {
      if (value == isError(true)) {
        Get.snackbar("internetProblem".tr, "internetDescription".tr,
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    });
  }

  getallEmployees() async {
    try {
      isLoading(true);
      var employees = await EmployeeRepository.getEmployees();
      if (employees != null) {
        allEmploees.value = employees;
        employeesBackup = employees;
      } else {
        Get.snackbar("sorry".tr, "dataEmpty".tr,
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } catch (error) {
      print(error);
      isError(true);
    } finally {
      isLoading(false);
    }
  }

  getJobsWithRankAndDepartment() async {
    try {
      var _allJobRankDepartment =
          await JobRankDepartmentRepository.getjobRankDepartment();
      if (_allJobRankDepartment != null) {
        allJobRankDepartments = _allJobRankDepartment;
      } else {
        Get.snackbar("sorry".tr, "dataEmpty".tr,
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } catch (error) {
      print(error);
      isError(true);
    } finally {
      isLoading(false);
    }
  }

  updateEmployee(
      Employees item,
      String name,
      String departmentId,
      String rankId,
      String jobId,
      String type,
      String contracted,
      String password,
      String employeeMembership,
      BuildContext context) async {
    try {
      isLoading(true);
      var result = await EmployeeRepository.editEmployee(
          item.id,
          name,
          departmentId,
          jobId,
          rankId,
          type,
          contracted,
          password,
          employeeMembership);
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
        item.departmentId = departmentId;
        item.password = password;
        item.jobId = jobId;
        item.rankId = rankId;
        item.type = type;
        item.contracted = contracted;
        item.employeeMembership = employeeMembership;

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

  deleteEmployee(String id, BuildContext context) async {
    try {
      isLoading(true);
      var result = await EmployeeRepository.deleteEmployee(id);

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

  addEmployee(
    BuildContext context,
    String name,
    String password,
    String departmentId,
    String jobId,
    String rankId,
    String type,
    String cotracted,
    String membership,
  ) async {
    try {
      isLoading(true);
      var result = await EmployeeRepository.addEmployee(name, password,
          departmentId, jobId, rankId, type, cotracted, membership);
      print(result.toString());

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
        var rankName;
        var jobName;
        var departmentName;
        allJobRankDepartments.department.forEach((element) {
          if (element.id == departmentId) {
            departmentName = element.name;
          }
        });
        allJobRankDepartments.jobs.forEach((element) {
          if (element.id == jobId) {
            jobName = element.name;
          }
        });
        allJobRankDepartments.ranks.forEach((element) {
          if (element.id == rankId) {
            rankName = element.name;
          }
        });

        Employees employeeItem = new Employees(
            id: result.toString(),
            name: name,
            password: password,
            departmentId: departmentId,
            jobId: jobId,
            rankId: rankId,
            type: type,
            contracted: cotracted,
            employeeMembership: membership,
            departmentName: departmentName,
            rankName: rankName,
            jobName: jobName);
        employeesBackup.add(employeeItem);
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
