import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:schedualmoon/component/app_color.dart';
import 'package:schedualmoon/component/drawer.dart';
import 'package:schedualmoon/controllers/app_responsive.dart';
import 'package:schedualmoon/controllers/course_controller.dart';
import 'package:schedualmoon/controllers/drawer_controller.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/controllers/employee_controller.dart';
import 'package:schedualmoon/controllers/teaching_matrix_controller.dart';
import 'package:schedualmoon/models/courses/courses.dart';
import 'package:schedualmoon/models/employees.dart';

class TeachingMatrixView extends StatelessWidget {
  final drawerController = Get.put(DrawerListController());
  final courseController = Get.put(CourseController());
  final employeeController = Get.put(EmployeesController());
  final teachingMatrixController = Get.put(TeachingMatrixController());
  @override
  Widget build(BuildContext context) {
    if (AppResponsive.isDesktop(context)) {
      drawerController.closeDrawer();
    }
    Employees employeeItem;
    return Scaffold(
      body: Row(
        children: [
          if (AppResponsive.isDesktop(context))
            Expanded(child: DrawerSection()),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                if (!AppResponsive.isDesktop(context))
                  Row(
                    children: [
                      Expanded(
                        flex: 0,
                        child: IconButton(
                            onPressed: () {
                              drawerController.openDrawer();
                            },
                            icon: Icon(
                              Icons.menu,
                              color: AppColor.blue,
                            )),
                      ),
                    ],
                  ),
                SizedBox(
                  height: 20,
                ),
                //this section for add item
                Row(
                  children: [
                    Expanded(
                        flex: 0,
                        child: Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: AppColor.lighteOrange,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        elevation: 0,
                                        backgroundColor: Colors.transparent,
                                        child: dialogContextTeachingMatrix(
                                            context),
                                      ));
                            },
                            child: Wrap(
                              children: <Widget>[
                                Icon(
                                  Icons.add,
                                  color: AppColor.bluelight,
                                  size: 24.0,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("add".tr, style: TextStyle(fontSize: 20)),
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
                //end add item
                Visibility(
                  visible: !teachingMatrixController.selectedEmployee.value,
                  child: Text(
                    'selectEmployeeToView'.tr,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //this section for select courses and employees
                Obx(() {
                  if (courseController.isLoading.value == true ||
                      employeeController.isLoading.value == true) {
                    return SizedBox();
                  } else {
                    employeeItem = employeeController.employeesBackup[0];
                    teachingMatrixController
                        .assignTeachingMatrix(employeeItem.id);
                    return Row(
                      children: [
                        Expanded(
                          child: StatefulBuilder(
                            builder: (BuildContext context, setState) {
                              return Container(
                                margin: AppResponsive.isDesktop(context)
                                    ? EdgeInsets.only(left: 250, right: 250)
                                    : null,
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                      labelText: "employeeName".tr,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color: AppColor.orange,
                                              width: 2)),
                                      labelStyle: TextStyle(
                                          color: AppColor.black, fontSize: 20)),
                                  value: employeeItem,
                                  iconSize: 24,
                                  elevation: 16,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  onChanged: (Employees? newValue) {
                                    setState(() {
                                      employeeItem = newValue!;
                                      teachingMatrixController
                                          .assignTeachingMatrix(
                                              employeeItem.id);
                                    });
                                  },
                                  items: employeeController.employeesBackup
                                      .map<DropdownMenuItem<Employees>>(
                                          (Employees value) {
                                    return DropdownMenuItem<Employees>(
                                      value: value,
                                      child: Center(
                                        child: Text(
                                          value.name,
                                          style: TextStyle(
                                              color: AppColor.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    );
                  }
                }),
                //end section for courses and employes
                SizedBox(
                  height: 20,
                ),
                //this section for view all teaching matrix

                //end teaching matrix
                SizedBox(
                  height: 20,
                ),
                Obx(() {
                  if (teachingMatrixController.isLoading.value == true ||
                      courseController.isLoading.value == true ||
                      employeeController.isLoading.value == true) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return SingleChildScrollView(
                      controller: ScrollController(),
                      child: Column(
                        children: [
                          DataTable(
                              headingRowColor: MaterialStateColor.resolveWith(
                                  (states) => AppColor.orange),
                              dataRowColor: MaterialStateColor.resolveWith(
                                  (states) => AppColor.grayLight),
                              headingTextStyle: TextStyle(
                                  color: AppColor.white, fontSize: 20),
                              dataTextStyle: TextStyle(
                                  color: AppColor.black, fontSize: 16),
                              columns: [
                                DataColumn(label: Text('delete'.tr)),
                                DataColumn(label: Text('courseName'.tr))
                              ],
                              rows: teachingMatrixController
                                  .allTeachingMatrixSpecificEmployee
                                  .map((element) => DataRow(cells: [
                                        DataCell(IconButton(
                                            onPressed: () {
                                              teachingMatrixController
                                                  .deleteTeachingMatrix(
                                                      element.id);
                                              teachingMatrixController
                                                  .assignTeachingMatrix(
                                                      element.id);
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: AppColor.redLight,
                                            ))),
                                        DataCell(Text(courseController
                                            .allCoursesBackup
                                            .where((course) =>
                                                course.id == element.courseId)
                                            .toList()[0]
                                            .arabicName))
                                      ]))
                                  .toList())
                        ],
                      ),
                    );
                  }
                })
              ],
            ),
          )
        ],
      ),
    );
  }

  dialogContextTeachingMatrix(BuildContext context) {
    Employees employeeItem = employeeController.employeesBackup[0];
    Courses courseItem = courseController.allCoursesBackup[0];
    return Stack(
      children: [
        Container(
          width: 450,
          padding: EdgeInsets.only(top: 100, bottom: 16, left: 16, right: 16),
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: Colors.blueAccent, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                )
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "courseAdd".tr,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 250,
                child: Column(
                  children: [
                    //add dropDown Here
                    StatefulBuilder(
                      builder: (BuildContext context, setState) {
                        return Column(
                          children: [
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                  labelText: "employeeName".tr,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: AppColor.orange, width: 2)),
                                  labelStyle: TextStyle(
                                      color: AppColor.black, fontSize: 20)),
                              value: employeeItem,
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              onChanged: (Employees? newValue) {
                                setState(() {
                                  employeeItem = newValue!;
                                });
                              },
                              items: employeeController.employeesBackup
                                  .map<DropdownMenuItem<Employees>>(
                                      (Employees value) {
                                return DropdownMenuItem<Employees>(
                                  value: value,
                                  child: Center(
                                    child: Text(
                                      value.name,
                                      style: TextStyle(
                                          color: AppColor.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            //drop down time from
                            SizedBox(
                              height: 25,
                            ),
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                  labelText: "courseName".tr,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: AppColor.orange, width: 2)),
                                  labelStyle: TextStyle(
                                      color: AppColor.black, fontSize: 20)),
                              value: courseItem,
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              onChanged: (Courses? newValue) {
                                setState(() {
                                  courseItem = newValue!;
                                });
                              },
                              items: courseController.allCoursesBackup
                                  .map<DropdownMenuItem<Courses>>(
                                      (Courses value) {
                                return DropdownMenuItem<Courses>(
                                  value: value,
                                  child: Center(
                                    child: Text(
                                      value.arabicName,
                                      style: TextStyle(
                                          color: AppColor.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            //end dropdown time from
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          if (teachingMatrixController.allTeachingMatrix
                                  .where((element) =>
                                      element.courseId == courseItem.id &&
                                      element.employeeId == employeeItem.id)
                                  .toList()
                                  .length ==
                              1) {
                            EasyLoading.showError('alreadyFound'.tr);
                          } else {
                            teachingMatrixController.addTeahingMatrix(
                                employeeItem.id, courseItem.id);
                          }
                        },
                        child: Text(
                          "confirm".tr,
                          style: TextStyle(
                              fontSize: 20, color: AppColor.greenEdit),
                        )),
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "cancel".tr,
                          style: TextStyle(
                              fontSize: 20.0, color: AppColor.redDelete),
                        )),
                  )
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 16,
          right: 16,
          child: CircleAvatar(
            radius: 50,
            child: Icon(
              Icons.add,
              size: 45,
              color: AppColor.white,
            ),
          ),
        )
      ],
    );
  }
}
