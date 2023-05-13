import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:schedualmoon/component/app_color.dart';
import 'package:schedualmoon/component/size_config.dart';
import 'package:schedualmoon/controllers/drawer_controller.dart';
import 'package:schedualmoon/controllers/employee_semester_controller.dart';
import 'package:schedualmoon/models/semester.dart';

class EmployeeSemesterView extends StatelessWidget {
  final departmentId = Get.arguments[0] as String;
  final semester = Get.arguments[1] as Semesters;
  final drawerController = Get.put(DrawerListController());
  @override
  Widget build(BuildContext context) {
    final employeeSemesterController = Get.put(EmployeeSemesterController(
        departmentId: departmentId, semesterId: semester.id));

    double _height = SizeConfig().getScreenHeight(context);
    return Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(_height * 0.04),
            child: SizedBox(),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  topRight: Radius.circular(100),
                  topLeft: Radius.circular(1500),
                  bottomRight: Radius.circular(1500))),
          elevation: 10,
          backgroundColor: AppColor.bluelight,
          shadowColor: AppColor.orange,
          centerTitle: true,
          title: Text(
            'employeeSemester'.tr,
            style: TextStyle(
                color: AppColor.white,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            //this section for view all employee semester
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Text(
                  'employeeSemesterDesc'.tr,
                  style: TextStyle(
                    color: AppColor.black,
                    fontSize: 20,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColor.lighteOrange,
                    ),
                    onPressed: () {
                      Get.toNamed('/classesView',
                          arguments: [departmentId, semester]);
                    },
                    child: Wrap(
                      children: <Widget>[
                        Icon(
                          Icons.next_plan,
                          color: AppColor.bluelight,
                          size: 24.0,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("next".tr, style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Obx(() {
              if (employeeSemesterController.isLoading.value == true) {
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return Expanded(
                  child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(
                        dragDevices: {
                          PointerDeviceKind.mouse,
                          PointerDeviceKind.touch,
                        },
                      ),
                      child: SingleChildScrollView(
                        controller: ScrollController(),
                        scrollDirection: Axis.vertical,
                        child: Center(
                          child: DataTable(
                              headingRowColor: MaterialStateColor.resolveWith(
                                  (states) => AppColor.orange),
                              dataRowColor: MaterialStateColor.resolveWith(
                                  (states) => AppColor.grayLight),
                              headingTextStyle: TextStyle(
                                  color: AppColor.white, fontSize: 20),
                              dataTextStyle: TextStyle(
                                  color: AppColor.black, fontSize: 16),
                              sortColumnIndex: 0,
                              columns: [
                                DataColumn(
                                    label: Text('employeeName'.tr),
                                    onSort: (i, b) {
                                      employeeSemesterController
                                          .allEmployeesSemester
                                          .sort((a, b) => a.employeeName
                                              .compareTo(b.employeeName));
                                    }),
                                DataColumn(label: Text('fullTime'.tr)),
                                DataColumn(label: Text('sa'.tr)),
                                DataColumn(label: Text('su'.tr)),
                                DataColumn(label: Text('mo'.tr)),
                                DataColumn(label: Text('tu'.tr)),
                                DataColumn(label: Text('we'.tr)),
                              ],
                              rows: employeeSemesterController
                                  .allEmployeesSemester
                                  .map((employeeSemesterElement) =>
                                      DataRow(cells: [
                                        DataCell(Text(employeeSemesterElement
                                            .employeeName)),
                                        //full time checkbox
                                        DataCell(
                                          StatefulBuilder(
                                            builder: (BuildContext context,
                                                setState) {
                                              return Checkbox(
                                                  value: employeeSemesterElement
                                                              .fullTime ==
                                                          1
                                                      ? true
                                                      : false,
                                                  onChanged: (val) async {
                                                    if (val == true) {
                                                      int _countOfDays = 0;
                                                      if (employeeSemesterElement
                                                              .days.sa ==
                                                          1) _countOfDays += 1;
                                                      if (employeeSemesterElement
                                                              .days.su ==
                                                          1) _countOfDays += 1;
                                                      if (employeeSemesterElement
                                                              .days.mo ==
                                                          1) _countOfDays += 1;
                                                      if (employeeSemesterElement
                                                              .days.tu ==
                                                          1) _countOfDays += 1;
                                                      if (employeeSemesterElement
                                                              .days.we ==
                                                          1) _countOfDays += 1;
                                                      if (_countOfDays < 3) {
                                                        EasyLoading.showError(
                                                            'fullTimeMinError'
                                                                .tr);
                                                      } else {
                                                        //update full time in database
                                                        var result = await employeeSemesterController.updateEmployeeSemester(
                                                            employeeSemesterElement
                                                                .employeeSemesterId
                                                                .toString(),
                                                            semester.id,
                                                            employeeSemesterElement
                                                                .employeeId
                                                                .toString(),
                                                            '1');
                                                        if (result == true) {
                                                          setState(() {
                                                            employeeSemesterElement
                                                                .fullTime = 1;
                                                          });
                                                        }
                                                      }
                                                    } else {
                                                      //check count of days
                                                      int _countOfDays = 0;
                                                      if (employeeSemesterElement
                                                              .days.sa ==
                                                          1) _countOfDays += 1;
                                                      if (employeeSemesterElement
                                                              .days.su ==
                                                          1) _countOfDays += 1;
                                                      if (employeeSemesterElement
                                                              .days.mo ==
                                                          1) _countOfDays += 1;
                                                      if (employeeSemesterElement
                                                              .days.tu ==
                                                          1) _countOfDays += 1;
                                                      if (employeeSemesterElement
                                                              .days.we ==
                                                          1) _countOfDays += 1;
                                                      if (_countOfDays > 2) {
                                                        EasyLoading.showError(
                                                            'fullTimeMaxError'
                                                                .tr);
                                                      } else {
                                                        //update full time in database
                                                        var result = await employeeSemesterController.updateEmployeeSemester(
                                                            employeeSemesterElement
                                                                .employeeSemesterId
                                                                .toString(),
                                                            semester.id,
                                                            employeeSemesterElement
                                                                .employeeId
                                                                .toString(),
                                                            '0');
                                                        if (result == true) {
                                                          setState(() {
                                                            employeeSemesterElement
                                                                .fullTime = 0;
                                                          });
                                                        }
                                                      }
                                                    }
                                                  });
                                            },
                                          ),
                                        ),
                                        //saterday
                                        DataCell(
                                          StatefulBuilder(
                                            builder: (BuildContext context,
                                                setState) {
                                              return Checkbox(
                                                  value: employeeSemesterElement
                                                              .days.sa ==
                                                          1
                                                      ? true
                                                      : false,
                                                  onChanged: (val) async {
                                                    if (val == true) {
                                                      var result =
                                                          await employeeSemesterController
                                                              .addDays('السبت',
                                                                  employeeSemesterElement);
                                                      if (result == true) {
                                                        setState(() {
                                                          employeeSemesterElement
                                                              .days.sa = 1;
                                                        });
                                                      }
                                                    } else {
                                                      var result =
                                                          await employeeSemesterController
                                                              .deleteDays(
                                                                  'السبت',
                                                                  employeeSemesterElement);
                                                      if (result == true) {
                                                        setState(() {
                                                          employeeSemesterElement
                                                              .days.sa = -1;
                                                        });
                                                      }
                                                    }
                                                  });
                                            },
                                          ),
                                        ),
                                        DataCell(
                                          StatefulBuilder(
                                            builder: (BuildContext context,
                                                setState) {
                                              return Checkbox(
                                                  value: employeeSemesterElement
                                                              .days.su ==
                                                          1
                                                      ? true
                                                      : false,
                                                  onChanged: (val) async {
                                                    if (val == true) {
                                                      var result =
                                                          await employeeSemesterController
                                                              .addDays('الأحد',
                                                                  employeeSemesterElement);
                                                      if (result == true) {
                                                        setState(() {
                                                          employeeSemesterElement
                                                              .days.su = 1;
                                                        });
                                                      }
                                                    } else {
                                                      var result =
                                                          await employeeSemesterController
                                                              .deleteDays(
                                                                  'الأحد',
                                                                  employeeSemesterElement);
                                                      if (result == true) {
                                                        setState(() {
                                                          employeeSemesterElement
                                                              .days.su = -1;
                                                        });
                                                      }
                                                    }
                                                  });
                                            },
                                          ),
                                        ),
                                        DataCell(
                                          StatefulBuilder(
                                            builder: (BuildContext context,
                                                setState) {
                                              return Checkbox(
                                                  value: employeeSemesterElement
                                                              .days.mo ==
                                                          1
                                                      ? true
                                                      : false,
                                                  onChanged: (val) async {
                                                    if (val == true) {
                                                      var result =
                                                          await employeeSemesterController
                                                              .addDays(
                                                                  'الاثنين',
                                                                  employeeSemesterElement);
                                                      if (result == true) {
                                                        setState(() {
                                                          employeeSemesterElement
                                                              .days.mo = 1;
                                                        });
                                                      }
                                                    } else {
                                                      var result =
                                                          await employeeSemesterController
                                                              .deleteDays(
                                                                  'الاثنين',
                                                                  employeeSemesterElement);
                                                      if (result == true) {
                                                        setState(() {
                                                          employeeSemesterElement
                                                              .days.mo = -1;
                                                        });
                                                      }
                                                    }
                                                  });
                                            },
                                          ),
                                        ),
                                        DataCell(
                                          StatefulBuilder(
                                            builder: (BuildContext context,
                                                setState) {
                                              return Checkbox(
                                                  value: employeeSemesterElement
                                                              .days.tu ==
                                                          1
                                                      ? true
                                                      : false,
                                                  onChanged: (val) async {
                                                    if (val == true) {
                                                      var result =
                                                          await employeeSemesterController
                                                              .addDays(
                                                                  'الثلاثاء',
                                                                  employeeSemesterElement);
                                                      if (result == true) {
                                                        setState(() {
                                                          employeeSemesterElement
                                                              .days.tu = 1;
                                                        });
                                                      }
                                                    } else {
                                                      var result =
                                                          await employeeSemesterController
                                                              .deleteDays(
                                                                  'الثلاثاء',
                                                                  employeeSemesterElement);
                                                      if (result == true) {
                                                        setState(() {
                                                          employeeSemesterElement
                                                              .days.tu = -1;
                                                        });
                                                      }
                                                    }
                                                  });
                                            },
                                          ),
                                        ),
                                        DataCell(
                                          StatefulBuilder(
                                            builder: (BuildContext context,
                                                setState) {
                                              return Checkbox(
                                                  value: employeeSemesterElement
                                                              .days.we ==
                                                          1
                                                      ? true
                                                      : false,
                                                  onChanged: (val) async {
                                                    if (val == true) {
                                                      var result =
                                                          await employeeSemesterController
                                                              .addDays(
                                                                  'الأربعاء',
                                                                  employeeSemesterElement);
                                                      if (result == true) {
                                                        setState(() {
                                                          employeeSemesterElement
                                                              .days.we = 1;
                                                        });
                                                      }
                                                    } else {
                                                      var result =
                                                          await employeeSemesterController
                                                              .deleteDays(
                                                                  'الأربعاء',
                                                                  employeeSemesterElement);
                                                      if (result == true) {
                                                        setState(() {
                                                          employeeSemesterElement
                                                              .days.we = -1;
                                                        });
                                                      }
                                                    }
                                                  });
                                            },
                                          ),
                                        )
                                      ]))
                                  .toList()),
                        ),
                      )),
                );
              }
            })
            //end view all employee semester
          ],
        ));
  }
}
