import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:schedualmoon/component/app_color.dart';
import 'package:schedualmoon/component/confirm_dialog.dart';
import 'package:schedualmoon/component/drawer.dart';
import 'package:schedualmoon/controllers/app_responsive.dart';
import 'package:schedualmoon/controllers/course_controller.dart';
import 'package:schedualmoon/controllers/drawer_controller.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/models/courses/courses.dart';

//below ignore immutable because
//i am update datasource when sorting .....
//if i write final _dataSource i can't update
// ignore: must_be_immutable
class CourseView extends StatelessWidget {
  final drawerController = Get.put(DrawerListController());
  final courseController = Get.put(CourseController());
  Rx<DataSource> _dataSource = DataSource().obs;
  int _rowsPerPage = 30;
  //this section for search
  bool _search = false;
  //end search
  //this section for filtering
  bool collegeSelected = false;
  bool yearSelected = false;
  bool semesterSelected = false;
  String departmentValue = "allColleges".tr;
  String yearValue = "allYear".tr;
  String semesterValue = "allSemester".tr;
  //end filtering
  @override
  Widget build(BuildContext context) {
    _dataSource = DataSource(context: context).obs;
    if (AppResponsive.isDesktop(context)) {
      drawerController.closeDrawer();
    }
    return Scaffold(
      body: Row(
        children: [
          if (AppResponsive.isDesktop(context))
            Expanded(child: DrawerSection()),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                //this section to icon drawer
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
                //icon drawer
                //this section for Add Item
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
                              Get.toNamed('/courseAdd');
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
                //End add Item
                //this section for filter and search
                Expanded(
                  flex: 0,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ListTile(
                          leading: Icon(
                            Icons.filter_list_outlined,
                            color: AppColor.bluelight,
                          ),
                          title: AppResponsive.isDesktop(context)
                              ? Text('sort'.tr)
                              : null,
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    elevation: 0,
                                    backgroundColor: Colors.transparent,
                                    child: dialogContextFiltering(
                                      context,
                                    )));
                          },
                        ),
                      ),
                      //this section for search by course name
                      Expanded(
                        flex: 4,
                        child: Container(
                          child: Center(
                            child: StatefulBuilder(
                              builder: (BuildContext context, setState) {
                                return AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  width: _search ? 300 : 50,
                                  height: _search ? 80 : 56,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),
                                    color: AppColor.white,
                                    boxShadow: kElevationToShadow[6],
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding: EdgeInsets.only(right: 16),
                                            child: !_search
                                                ? null
                                                : TextField(
                                                    onChanged: (val) {
                                                      var result = courseController
                                                          .allCoursesBackup
                                                          .where((element) =>
                                                              element.arabicName
                                                                  .contains(
                                                                      val) ||
                                                              element
                                                                  .englishName
                                                                  .contains(
                                                                      val))
                                                          .toList();
                                                      courseController
                                                          .allCourses
                                                          .value = result;
                                                      _dataSource.value =
                                                          DataSource(
                                                              context: context);
                                                    },
                                                    maxLength: 50,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            'arabicName'.tr,
                                                        hintStyle: TextStyle(
                                                            color:
                                                                AppColor.blue),
                                                        border:
                                                            InputBorder.none),
                                                  ),
                                          )),
                                      Expanded(
                                        flex: 0,
                                        child: Material(
                                          type: MaterialType.transparency,
                                          child: InkWell(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(30),
                                                bottomRight: Radius.circular(
                                                    _search ? 0 : 32),
                                                bottomLeft: Radius.circular(30),
                                                topRight: Radius.circular(
                                                    _search ? 0 : 32)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Icon(
                                                _search
                                                    ? Icons.close
                                                    : Icons.search,
                                                color: AppColor.blue,
                                              ),
                                            ),
                                            onTap: () {
                                              if (_search == false)
                                                setState(() {
                                                  _search = true;
                                                });
                                              else
                                                setState(() {
                                                  _search = false;
                                                });
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      )
                      //end search by course name
                    ],
                  ),
                ),
                //filter and search
                SizedBox(
                  height: 10,
                ),
                //get data  from repository
                Obx(() {
                  if (courseController.isLoading.value == true) {
                    return Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
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
                              child: PaginatedDataTable(
                                  sortColumnIndex: 0,
                                  arrowHeadColor: AppColor.blue,
                                  showFirstLastButtons: true,
                                  showCheckboxColumn: false,
                                  rowsPerPage: _rowsPerPage,
                                  columns: [
                                    DataColumn(
                                      label: Text(
                                        'update'.tr,
                                        style: TextStyle(
                                            color: AppColor.blue,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'delete'.tr,
                                        style: TextStyle(
                                            color: AppColor.blue,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataColumn(
                                        label: Text(
                                          'courseId'.tr,
                                          style: TextStyle(
                                              color: AppColor.blue,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onSort: (i, b) {
                                          courseController.allCourses.sort(
                                              (a, b) => a.id.compareTo(b.id));
                                          _dataSource.value =
                                              DataSource(context: context);
                                        }),
                                    DataColumn(
                                        label: Text(
                                      'arabicName'.tr,
                                      style: TextStyle(
                                          color: AppColor.blue,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    DataColumn(
                                        label: Text(
                                          'totalHour'.tr,
                                          style: TextStyle(
                                              color: AppColor.blue,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        numeric: true),
                                    DataColumn(
                                        label: Text(
                                          'theoriticalHour'.tr,
                                          style: TextStyle(
                                              color: AppColor.blue,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        numeric: true),
                                    DataColumn(
                                        label: Text(
                                          'labHour'.tr,
                                          style: TextStyle(
                                              color: AppColor.blue,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        numeric: true),
                                    DataColumn(
                                        label: Text(
                                          'year'.tr,
                                          style: TextStyle(
                                              color: AppColor.blue,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        numeric: true),
                                    DataColumn(
                                        label: Text(
                                          'semesterNumebr'.tr,
                                          style: TextStyle(
                                              color: AppColor.blue,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        numeric: true),
                                    DataColumn(
                                        label: Text(
                                      'departmentName'.tr,
                                      style: TextStyle(
                                          color: AppColor.blue,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    DataColumn(
                                        label: Directionality(
                                          textDirection: TextDirection.ltr,
                                          child: Text(
                                            'englishName'.tr,
                                            style: TextStyle(
                                                color: AppColor.blue,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        numeric: false),
                                  ],
                                  source: _dataSource.value)),
                        ),
                      ),
                    );
                  }
                })
                //end repository
              ],
            ),
          )
        ],
      ),
    );
  }

  //this method to update datasource from another class
  //using in DataSource Class
  deleteItem(String id, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => ConfirmDialog(
              title: "deleteTitle".tr,
              description: "deleteDescription".tr,
              positivePress: () async {
                print('before :' +
                    courseController.allCourses
                        .where((p0) => p0.id == id)
                        .toList()[0]
                        .id);
                var result = await courseController.deleteCourse(id);
                if (result == true) {
                  courseController.allCourses
                      .removeWhere((element) => element.id == id);
                  courseController.allCoursesBackup
                      .removeWhere((element) => element.id == id);
                  _dataSource.value = DataSource(context: context);
                  Navigator.pop(context);
                }
              },
              cancelPrsee: () {
                Navigator.pop(context);
              },
              icon: Icons.delete,
              iconColor: AppColor.white,
            ));
  }

  dialogContextFiltering(BuildContext context) {
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
                "sort".tr,
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
                            //this section for college filter
                            Row(
                              children: [
                                Expanded(
                                    flex: 0,
                                    child: Checkbox(
                                      value: collegeSelected,
                                      onChanged: (val) async {
                                        if (collegeSelected == true) {
                                          setState(() {
                                            collegeSelected = false;
                                          });
                                        } else {
                                          setState(() {
                                            collegeSelected = true;
                                          });
                                        }
                                      },
                                    )),
                                Expanded(
                                  child: IgnorePointer(
                                    ignoring: !collegeSelected,
                                    child: DropdownButtonFormField(
                                      decoration: InputDecoration(
                                          labelText: "departmentSelectDesc".tr,
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: BorderSide(
                                                  color: AppColor.orange,
                                                  width: 2)),
                                          labelStyle: TextStyle(
                                              color: AppColor.black,
                                              fontSize: 20)),
                                      value: departmentValue,
                                      iconSize: 24,
                                      elevation: 16,
                                      style: const TextStyle(
                                          color: Colors.deepPurple),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          departmentValue = newValue!;
                                        });
                                      },
                                      items: courseController.allColegeDistinct
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Center(
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                  color: AppColor.blue,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            //end section for college filter
                            SizedBox(
                              height: 25,
                            ),
                            //this section for year filter
                            Row(
                              children: [
                                Expanded(
                                    flex: 0,
                                    child: Checkbox(
                                      value: yearSelected,
                                      onChanged: (val) async {
                                        if (yearSelected == true) {
                                          setState(() {
                                            yearSelected = false;
                                          });
                                        } else {
                                          setState(() {
                                            yearSelected = true;
                                          });
                                        }
                                      },
                                    )),
                                Expanded(
                                  child: IgnorePointer(
                                    ignoring: !yearSelected,
                                    child: DropdownButtonFormField(
                                      decoration: InputDecoration(
                                          labelText: "yearSelectedDesc".tr,
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: BorderSide(
                                                  color: AppColor.orange,
                                                  width: 2)),
                                          labelStyle: TextStyle(
                                              color: AppColor.black,
                                              fontSize: 20)),
                                      value: yearValue,
                                      iconSize: 24,
                                      elevation: 16,
                                      style: const TextStyle(
                                          color: Colors.deepPurple),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          yearValue = newValue!;
                                        });
                                      },
                                      items: courseController.allYearDistinct
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Center(
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                  color: AppColor.blue,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            //end year filter

                            SizedBox(
                              height: 25,
                            ),

                            //this section for semester Filter
                            Row(
                              children: [
                                Expanded(
                                    flex: 0,
                                    child: Checkbox(
                                      value: semesterSelected,
                                      onChanged: (val) async {
                                        if (semesterSelected == true) {
                                          setState(() {
                                            semesterSelected = false;
                                          });
                                        } else {
                                          setState(() {
                                            semesterSelected = true;
                                          });
                                        }
                                      },
                                    )),
                                Expanded(
                                  child: IgnorePointer(
                                    ignoring: !semesterSelected,
                                    child: DropdownButtonFormField(
                                      decoration: InputDecoration(
                                          labelText: "semesterSelectedDesc".tr,
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: BorderSide(
                                                  color: AppColor.orange,
                                                  width: 2)),
                                          labelStyle: TextStyle(
                                              color: AppColor.black,
                                              fontSize: 20)),
                                      value: semesterValue,
                                      iconSize: 24,
                                      elevation: 16,
                                      style: const TextStyle(
                                          color: Colors.deepPurple),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          semesterValue = newValue!;
                                        });
                                      },
                                      items: courseController
                                          .allSemesterDistinct
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Center(
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                  color: AppColor.blue,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            //end Semester Filter
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
                          if (!yearSelected &&
                              !semesterSelected &&
                              !collegeSelected) {
                            courseController.allCourses.value =
                                courseController.allCoursesBackup;
                            _dataSource.value = DataSource(context: context);
                            _rowsPerPage = 30;
                            Navigator.pop(context);
                          } else {
                            var result = courseController.allCoursesBackup;
                            if (collegeSelected &&
                                departmentValue != "allColleges".tr) {
                              result = result
                                  .where((element) =>
                                      element.departmentName == departmentValue)
                                  .toList();
                            }
                            if (yearSelected && yearValue != "allYear".tr) {
                              result = result
                                  .where((element) =>
                                      element.year == int.parse(yearValue))
                                  .toList();
                            }
                            if (semesterSelected &&
                                semesterValue != "allSemester".tr) {
                              result = result
                                  .where((element) =>
                                      element.semester ==
                                      int.parse(semesterValue))
                                  .toList();
                            }
                            courseController.allCourses.value = result;
                            _dataSource.value = DataSource(context: context);
                            if (courseController.allCourses.length < 30)
                              _rowsPerPage = courseController.allCourses.length;
                            else
                              _rowsPerPage = 30;
                            Navigator.pop(context);
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
              Icons.filter_list_outlined,
              size: 45,
              color: AppColor.white,
            ),
          ),
        )
      ],
    );
  }
}

class DataSource extends DataTableSource {
  final courseController = Get.put(CourseController());
  final context;

  DataSource({this.context});
  @override
  DataRow? getRow(int index) {
    Courses courseItem = courseController.allCourses[index];
    return DataRow(
        color: MaterialStateProperty.resolveWith(
            (states) => _getDataRowColor(states)),
        onSelectChanged: (bl) => {},
        cells: [
          DataCell(IconButton(
              onPressed: () {
                Get.toNamed('/courseUpdate',
                    arguments: [courseItem, courseController]);
              },
              icon: Icon(
                Icons.edit,
                color: AppColor.greenEdit,
              ))),
          DataCell(IconButton(
              onPressed: () {
                CourseView _courseview = CourseView();
                _courseview.deleteItem(courseItem.id, context);
              },
              icon: Icon(
                Icons.delete,
                color: AppColor.redLight,
              ))),
          DataCell(Text(
            courseItem.id,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )),
          DataCell(Text(
            courseItem.arabicName,
            style: TextStyle(fontSize: 16),
          )),
          DataCell(Text(
            courseItem.totalHour.toString(),
            style: TextStyle(fontSize: 16),
          )),
          DataCell(Text(
            courseItem.theoriticalHour.toString(),
            style: TextStyle(fontSize: 16),
          )),
          DataCell(Text(
            courseItem.labHour.toString(),
            style: TextStyle(fontSize: 16),
          )),
          DataCell(Text(
            courseItem.year.toString(),
            style: TextStyle(fontSize: 16),
          )),
          DataCell(Text(
            courseItem.semester.toString(),
            style: TextStyle(fontSize: 16),
          )),
          DataCell(Text(
            courseItem.departmentName,
            style: TextStyle(fontSize: 16),
          )),
          DataCell(Directionality(
              textDirection: TextDirection.ltr,
              child: Text(
                courseItem.englishName,
                style: TextStyle(fontSize: 16),
              ))),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => courseController.allCourses.length;

  @override
  int get selectedRowCount => 0;
  Color _getDataRowColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.hovered,
      MaterialState.focused,
    };

    if (states.any(interactiveStates.contains)) {
      return AppColor.orange;
    } else if (states.contains(MaterialState.pressed)) {
      return AppColor.grayLight;
    }
    return Colors.transparent;
  }
}
