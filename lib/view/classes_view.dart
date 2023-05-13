import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:schedualmoon/component/app_color.dart';
import 'package:schedualmoon/controllers/class_controller.dart';
import 'package:schedualmoon/controllers/gentic_algorithm_controller.dart';
import 'package:schedualmoon/models/classes.dart';
import 'package:schedualmoon/models/doctor_off.dart';
import 'package:schedualmoon/models/semester.dart';
import 'package:schedualmoon/models/teach_hour.dart';
import 'package:schedualmoon/models/teaching_matrix_menu_item.dart';

// ignore: must_be_immutable
class ClassesView extends StatelessWidget {
  final departmentId = Get.arguments[0] as String;
  final semester = Get.arguments[1] as Semesters;
  final genticAlgorithmController = Get.put(GenticAlgorithmController());
  int _rowsPerPage = 12;
  @override
  Widget build(BuildContext context) {
    //this section for employee off
    String _timeTo = "";
    String _timeFrom = "";
    String _selectedDay = "";
    TeachingMatrixMenuItem _employeeOff =
        TeachingMatrixMenuItem(employeeId: "", employeeName: "");
    DoctorOff _speceficDoctorOff = DoctorOff();
    _speceficDoctorOff.employeeId = "";
    List<DoctorOff> _allDoctorOff = <DoctorOff>[];
    List<String> _alldays = ['sa'.tr, 'su'.tr, 'mo'.tr, 'tu'.tr, 'we'.tr];
    _selectedDay = _alldays[0];
    List<String> _alltimeFrom = [
      '8',
      '10',
      '12',
      '2',
    ];

    _timeFrom = _alltimeFrom[0];
    List<String> _allTimeTo = ['10', '12', '2', '4'];

    _timeTo = _allTimeTo[0];
    //end employee pff
    final classController = Get.put(
        ClassController(departmentId: departmentId, semesterId: semester.id));
    Rx<DataSource> _dataSource =
        DataSource(context: context, classController: classController).obs;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            labelColor: AppColor.grayLight,
            labelStyle: TextStyle(fontSize: 20),
            indicatorColor: AppColor.bluelight,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                icon: Icon(
                  Icons.menu_book_outlined,
                  color: AppColor.bluelight,
                  size: 30,
                ),
                text: 'departmentCourses'.tr,
              ),
              Tab(
                icon: Icon(
                  Icons.menu_book_outlined,
                  color: AppColor.bluelight,
                  size: 30,
                ),
                text: 'reqiurementsCourses'.tr,
              ),
              Tab(
                icon: Icon(
                  Icons.space_dashboard_rounded,
                  color: AppColor.bluelight,
                  size: 30,
                ),
                text: 'classes'.tr,
              ),
              Tab(
                icon: Icon(
                  Icons.date_range,
                  color: AppColor.bluelight,
                  size: 30,
                ),
                text: 'program'.tr,
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  topRight: Radius.circular(100),
                  topLeft: Radius.circular(1500),
                  bottomRight: Radius.circular(1500))),
          elevation: 0,
          backgroundColor: Colors.orange,
          shadowColor: AppColor.orange,
          centerTitle: true,
          title: Text(
            'classesSpecific'.tr,
            style: TextStyle(
                color: AppColor.white,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Obx(() {
          if (classController.isLoading.value == true) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            //this section for employee off
            _employeeOff = classController.allDepartmentsEmployee[0];
            _speceficDoctorOff.employeeId =
                classController.allDepartmentsEmployee[0].employeeId;
            //end employee off
            return TabBarView(
              children: [
                //this section for courses

                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
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
                        child: Column(
                          children: [
                            Expanded(
                                flex: 0,
                                child: Row(
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: AppColor.lighteOrange,
                                        ),
                                        onPressed: () {
                                          //test if found any courses before opening
                                          Get.toNamed('/openCourse',
                                              arguments: [
                                                classController,
                                                semester,
                                                departmentId
                                              ]);
                                        },
                                        child: Wrap(
                                          children: <Widget>[
                                            Icon(
                                              Icons.person_add_rounded,
                                              color: AppColor.bluelight,
                                              size: 24.0,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text("add".tr,
                                                style: TextStyle(fontSize: 20)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: AppColor.lighteOrange,
                                        ),
                                        onPressed: () async {
                                          //test if found any courses before opening
                                          await classController.updateClasses();
                                        },
                                        child: Wrap(
                                          children: <Widget>[
                                            Icon(
                                              Icons.refresh,
                                              color: AppColor.bluelight,
                                              size: 24.0,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text("refresh".tr,
                                                style: TextStyle(fontSize: 20)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            DataTable(
                                headingRowColor: MaterialStateColor.resolveWith(
                                    (states) => AppColor.bluelight),
                                dataRowColor: MaterialStateColor.resolveWith(
                                    (states) => AppColor.grayLight),
                                headingTextStyle: TextStyle(
                                    color: AppColor.white, fontSize: 20),
                                dataTextStyle: TextStyle(
                                    color: AppColor.black, fontSize: 16),
                                sortColumnIndex: 0,
                                columns: [
                                  DataColumn(label: Text('edit'.tr)),
                                  DataColumn(label: Text('courseId'.tr)),
                                  DataColumn(label: Text('arabicName'.tr)),
                                  DataColumn(label: Text('totalHour'.tr)),
                                  DataColumn(label: Text('theoriticalHour'.tr)),
                                  DataColumn(label: Text('labHour'.tr)),
                                  DataColumn(label: Text('year'.tr)),
                                  DataColumn(label: Text('semester'.tr)),
                                  DataColumn(label: Text('theoryCount'.tr)),
                                  DataColumn(label: Text('labCount'.tr))
                                ],
                                rows: classController.allDepartmentCourses
                                    .map((courseElement) => DataRow(cells: [
                                          DataCell(Container(
                                            child: IconButton(
                                              icon: Icon(Icons.edit),
                                              onPressed: () {
                                                //TODO: must edit this
                                              },
                                              color: AppColor.greenEdit,
                                            ),
                                          )),
                                          DataCell(Text(courseElement.id)),
                                          DataCell(
                                              Text(courseElement.arabicName)),
                                          DataCell(Text(courseElement.totalHour
                                              .toString())),
                                          DataCell(Text(courseElement
                                              .theoriticalHour
                                              .toString())),
                                          DataCell(Text(courseElement.labHour
                                              .toString())),
                                          DataCell(Text(
                                              courseElement.year.toString())),
                                          DataCell(Text(courseElement.semester
                                              .toString())),
                                          DataCell(Text(classController
                                              .allClasses
                                              .where((p0) =>
                                                  p0.courseId ==
                                                      courseElement.id &&
                                                  p0.classLapOrNot == "0")
                                              .toList()
                                              .length
                                              .toString())),
                                          DataCell(Text(classController
                                              .allClasses
                                              .where((p0) =>
                                                  p0.courseId ==
                                                      courseElement.id &&
                                                  p0.classLapOrNot == "1")
                                              .toList()
                                              .length
                                              .toString()))
                                        ]))
                                    .toList()),
                          ],
                        )),
                  ),
                ),

                //end courses section
                //this sectionn for reqiurements courses
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
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
                        child: Column(
                          children: [
                            Expanded(
                                flex: 0,
                                child: Row(
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: AppColor.lighteOrange,
                                        ),
                                        onPressed: () {
                                          //test if found any courses before opening
                                          Get.toNamed('/openCourseReqiurement',
                                              arguments: [
                                                classController,
                                                semester,
                                                departmentId
                                              ]);
                                        },
                                        child: Wrap(
                                          children: <Widget>[
                                            Icon(
                                              Icons.person_add_rounded,
                                              color: AppColor.bluelight,
                                              size: 24.0,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text("add".tr,
                                                style: TextStyle(fontSize: 20)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            DataTable(
                                headingRowColor: MaterialStateColor.resolveWith(
                                    (states) => AppColor.bluelight),
                                dataRowColor: MaterialStateColor.resolveWith(
                                    (states) => AppColor.grayLight),
                                headingTextStyle: TextStyle(
                                    color: AppColor.white, fontSize: 20),
                                dataTextStyle: TextStyle(
                                    color: AppColor.black, fontSize: 16),
                                sortColumnIndex: 0,
                                columns: [
                                  DataColumn(label: Text('courseId'.tr)),
                                  DataColumn(label: Text('arabicName'.tr)),
                                  DataColumn(label: Text('totalHour'.tr)),
                                  DataColumn(label: Text('theoriticalHour'.tr)),
                                  DataColumn(label: Text('labHour'.tr)),
                                  DataColumn(label: Text('year'.tr)),
                                  DataColumn(label: Text('semester'.tr)),
                                  DataColumn(label: Text('theoryCount'.tr)),
                                  DataColumn(label: Text('labCount'.tr))
                                ],
                                rows: classController.allReqiurementsCourses
                                    .map((courseElement) => DataRow(cells: [
                                          DataCell(Text(courseElement.id)),
                                          DataCell(
                                              Text(courseElement.arabicName)),
                                          DataCell(Text(courseElement.totalHour
                                              .toString())),
                                          DataCell(Text(courseElement
                                              .theoriticalHour
                                              .toString())),
                                          DataCell(Text(courseElement.labHour
                                              .toString())),
                                          DataCell(Text(
                                              courseElement.year.toString())),
                                          DataCell(Text(courseElement.semester
                                              .toString())),
                                          DataCell(Text(classController
                                              .allClasses
                                              .where((p0) =>
                                                  p0.courseId ==
                                                      courseElement.id &&
                                                  p0.classLapOrNot == "0")
                                              .toList()
                                              .length
                                              .toString())),
                                          DataCell(Text(classController
                                              .allClasses
                                              .where((p0) =>
                                                  p0.courseId ==
                                                      courseElement.id &&
                                                  p0.classLapOrNot == "1")
                                              .toList()
                                              .length
                                              .toString()))
                                        ]))
                                    .toList()),
                          ],
                        )),
                  ),
                ),
                //end reqiurements courses
                //this section for classes
                Container(
                  margin: EdgeInsets.all(10),
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
                              'courseId'.tr,
                              style: TextStyle(
                                  color: AppColor.blue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
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
                            'islab'.tr,
                            style: TextStyle(
                                color: AppColor.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
                          DataColumn(
                              label: Text(
                            'hourCount'.tr,
                            style: TextStyle(
                                color: AppColor.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
                          DataColumn(
                              label: Text(
                            'classNumber'.tr,
                            style: TextStyle(
                                color: AppColor.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
                          DataColumn(
                              label: Text(
                            'teacherName'.tr,
                            style: TextStyle(
                                color: AppColor.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
                          DataColumn(
                              label: Text(
                            'rankHour'.tr,
                            style: TextStyle(
                                color: AppColor.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
                        ],
                        source: _dataSource.value,
                      ),
                    ),
                  ),
                ),
                //end section for classes

                //this section for program
                StatefulBuilder(
                  builder: (BuildContext context, setState) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      child: Form(
                        child: ListView(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  'doctorOffDesc'.tr,
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
                                    onPressed: () async {
                                      String jsonString =
                                          doctorOffToJson(_allDoctorOff);
                                      print(jsonString);
                                      var result =
                                          await genticAlgorithmController.run(
                                              semester.semester,
                                              jsonString,
                                              departmentId,
                                              semester.id);
                                      if (result != "") {
                                        Get.toNamed('/program', arguments: [
                                          classController,
                                          result
                                        ]);
                                      }
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
                                        Text("next".tr,
                                            style: TextStyle(fontSize: 20)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Container(
                                width: 450,
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                      labelText: "selectEmployee".tr,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color: AppColor.orange,
                                              width: 2)),
                                      labelStyle: TextStyle(
                                          color: AppColor.black, fontSize: 20)),
                                  value: _employeeOff,
                                  iconSize: 24,
                                  elevation: 16,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  onChanged:
                                      (TeachingMatrixMenuItem? newValue) {
                                    setState(() {
                                      _employeeOff = newValue!;
                                    });
                                  },
                                  items: classController.allDepartmentsEmployee
                                      .map<
                                              DropdownMenuItem<
                                                  TeachingMatrixMenuItem>>(
                                          (TeachingMatrixMenuItem value) {
                                    return DropdownMenuItem<
                                        TeachingMatrixMenuItem>(
                                      value: value,
                                      child: Center(
                                        child: Text(
                                          value.employeeName,
                                          style: TextStyle(
                                              color: AppColor.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: Container(
                                width: 450,
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                      labelText: "selectDay".tr,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color: AppColor.orange,
                                              width: 2)),
                                      labelStyle: TextStyle(
                                          color: AppColor.black, fontSize: 20)),
                                  value: _selectedDay,
                                  iconSize: 24,
                                  elevation: 16,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedDay = newValue!;
                                    });
                                  },
                                  items: _alldays.map<DropdownMenuItem<String>>(
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
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: Container(
                                width: 450,
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                      labelText: "timeFrom".tr,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color: AppColor.orange,
                                              width: 2)),
                                      labelStyle: TextStyle(
                                          color: AppColor.black, fontSize: 20)),
                                  value: _timeFrom,
                                  iconSize: 24,
                                  elevation: 16,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _timeFrom = newValue!;
                                    });
                                  },
                                  items: _alltimeFrom
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
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: Container(
                                width: 450,
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                      labelText: "timeTo".tr,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color: AppColor.orange,
                                              width: 2)),
                                      labelStyle: TextStyle(
                                          color: AppColor.black, fontSize: 20)),
                                  value: _timeTo,
                                  iconSize: 24,
                                  elevation: 16,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _timeTo = newValue!;
                                    });
                                  },
                                  items: _allTimeTo
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
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: AppColor.lighteOrange,
                                  ),
                                  onPressed: () {
                                    bool _alreadyFound = false;
                                    _allDoctorOff.forEach((element) {
                                      if (element.employeeId ==
                                          _employeeOff.employeeId) {
                                        _alreadyFound = true;
                                      }
                                    });
                                    if (_alreadyFound) {
                                      Period _period = Period(
                                          day: _selectedDay,
                                          timeFrom: _timeFrom,
                                          timeTo: _timeTo);
                                      int lengthTest = _allDoctorOff
                                          .where((element) =>
                                              element.employeeId ==
                                              _employeeOff.employeeId)
                                          .toList()[0]
                                          .periods
                                          .where((element) =>
                                              element.day == _selectedDay &&
                                              element.timeFrom == _timeFrom &&
                                              element.timeTo == _timeTo)
                                          .toList()
                                          .length;
                                      if (lengthTest == 0) {
                                        _allDoctorOff
                                            .where((element) =>
                                                element.employeeId ==
                                                _employeeOff.employeeId)
                                            .toList()[0]
                                            .periods
                                            .add(_period);
                                      } else {
                                        EasyLoading.showError('periodFound'.tr);
                                      }
                                    } else {
                                      Period _period = Period(
                                          day: _selectedDay,
                                          timeFrom: _timeFrom,
                                          timeTo: _timeTo);
                                      DoctorOff _new = DoctorOff();
                                      _new.employeeId = _employeeOff.employeeId;
                                      _new.periods.add(_period);
                                      _allDoctorOff.add(_new);
                                    }
                                    setState(() {});
                                  },
                                  child: Wrap(
                                    children: <Widget>[
                                      Icon(
                                        Icons.person_add_rounded,
                                        color: AppColor.bluelight,
                                        size: 24.0,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("add".tr,
                                          style: TextStyle(fontSize: 20)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Center(
                              child: Container(
                                child: DataTable(
                                    headingRowColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => AppColor.bluelight),
                                    dataRowColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => AppColor.grayLight),
                                    headingTextStyle: TextStyle(
                                        color: AppColor.white, fontSize: 20),
                                    dataTextStyle: TextStyle(
                                        color: AppColor.black, fontSize: 16),
                                    columns: [
                                      DataColumn(label: Text('day'.tr)),
                                      DataColumn(
                                          label: Text('timeFrom'.tr),
                                          numeric: true),
                                      DataColumn(
                                        label: Text('timeTo'.tr),
                                        numeric: true,
                                      ),
                                      DataColumn(label: Text('delete'.tr)),
                                    ],
                                    rows: _allDoctorOff
                                                .where((element) =>
                                                    element.employeeId ==
                                                    _employeeOff.employeeId)
                                                .toList()
                                                .length !=
                                            0
                                        ? _allDoctorOff
                                            .where((element) =>
                                                element.employeeId ==
                                                _employeeOff.employeeId)
                                            .toList()[0]
                                            .periods
                                            .map((periodElement) =>
                                                DataRow(cells: [
                                                  DataCell(
                                                      Text(periodElement.day)),
                                                  DataCell(Text(
                                                      periodElement.timeFrom)),
                                                  DataCell(Text(
                                                      periodElement.timeTo)),
                                                  DataCell(IconButton(
                                                      onPressed: () {
                                                        //TODO:delete Element from periods
                                                      },
                                                      icon: Icon(
                                                        Icons.delete,
                                                        color:
                                                            AppColor.redLight,
                                                      ))),
                                                ]))
                                            .toList()
                                        : <DataRow>[]),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                //end program section
              ],
            );
          }
        }),
      ),
    );
  }
}

//this data source for paginated dataTable
class DataSource extends DataTableSource {
  final ClassController classController;
  final context;

  DataSource({this.context, required this.classController});
  @override
  DataRow? getRow(int index) {
    Classes classItem = classController.allClasses[index];
    //fill list for dropdown menu item
    List<TeachingMatrixMenuItem> _courseTeachers = <TeachingMatrixMenuItem>[];
    //if course is an theoriticl course need to tteaching matrix
    if (classItem.classLapOrNot == "0") {
      var _allCourseTeachers = classController.allDepartmentTeachingMatrix
          .where((item) => item.courseId == classItem.courseId)
          .toList();
      _allCourseTeachers.forEach((element) {
        TeachingMatrixMenuItem _menuItem = TeachingMatrixMenuItem(
            employeeId: element.employeeId, employeeName: element.name);
        _courseTeachers.add(_menuItem);
      });
    } else {
      classController.allDepartmentsEmployee.forEach((element) {
        _courseTeachers.add(element);
      });
    }
    //TODO: Must edit to compatible with all de3partment that contain on employees
    TeachingMatrixMenuItem _specificItem = _courseTeachers
        .where((element) => element.employeeId == classItem.employeeId)
        .toList()[0];

    //end fill list

    //this section for progress indicator
    //first specific element
    TeachHour _teachHour = classController.allTeachHour
        .where((item) => item.employeeId == int.parse(classItem.employeeId))
        .toList()[0];
    double percentage = _teachHour.hourClasses / _teachHour.hourNumber;
    if (percentage > 1) percentage = 1;
    //end progress indicator
    return DataRow(
        color: MaterialStateProperty.resolveWith(
            (states) => _getDataRowColor(states)),
        onSelectChanged: (bl) => {},
        cells: [
          DataCell(Text(
            classItem.courseId,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )),
          DataCell(Text(
            classItem.arName,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )),
          DataCell(Text(
            classItem.classLapOrNot,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )),

          DataCell(Text(
            classItem.hourNumber,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )),
          DataCell(Text(
            classItem.classNumber,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )),
          //drop down menu item contain on teacher that teach this course
          DataCell(
            StatefulBuilder(
              builder: (BuildContext context, setState) {
                return DropdownButtonFormField(
                  value: _specificItem,
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  onChanged: (TeachingMatrixMenuItem? newValue) {
                    setState(() {
                      _specificItem = newValue!;
                    });
                  },
                  items: _courseTeachers
                      .map<DropdownMenuItem<TeachingMatrixMenuItem>>(
                          (TeachingMatrixMenuItem value) {
                    return DropdownMenuItem<TeachingMatrixMenuItem>(
                      value: value,
                      child: Center(
                        child: Text(
                          value.employeeName,
                          style: TextStyle(
                              color: AppColor.blue,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          DataCell(LinearPercentIndicator(
            width: 150,
            percent: percentage,
            lineHeight: 18,
            backgroundColor: AppColor.grayLight,
            progressColor: percentage < 0.75 ? AppColor.green : AppColor.red,
            center: Text(_teachHour.hourClasses.toString() +
                "/" +
                _teachHour.hourNumber.toString()),
          )),

          //end drop down menu
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => classController.allClasses.length;

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
//end data source for paginated dataTable
