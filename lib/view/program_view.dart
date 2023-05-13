import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:schedualmoon/component/app_color.dart';
import 'package:schedualmoon/component/size_config.dart';
import 'package:schedualmoon/controllers/class_controller.dart';
import 'package:schedualmoon/models/csv_convert.dart';
import 'package:schedualmoon/models/genes.dart';
import 'package:schedualmoon/models/program.dart';

// ignore: must_be_immutable
class ProgramView extends StatelessWidget {
  final classController = Get.arguments[0] as ClassController;
  final genesJson = Get.arguments[1] as String;
  RxBool isLoading = true.obs;

  intilaizeProgram(List<Genes> _allGenes, ClassController _classController,
      List<Program> _allPrograms) {
    _allGenes.forEach((element) {
      Program _class = Program();
      //first intilaize time from gene
      String _time = element.timeFrom + "_" + element.timeTo;
      _class.time = _time;
      //second intilaize day from gene
      String _day = "";
      if (element.day == 1) {
        _day = "السبت";
      } else if (element.day == 2) {
        _day = "الأحد";
      } else if (element.day == 3) {
        _day = "الإثنين";
      } else if (element.day == 4) {
        _day = "الثلاثاء";
      } else if (element.day == 5) {
        _day = "الأربعاء";
      }
      _class.day = _day;
      //third intilaize student count | courseId | teacher name | theory |  lab | course name
      String _studentCount = "";
      String _courseId = "";
      String _teacherName = "";
      String _theory = "";
      String _lab = "";
      String _courseName = "";
      _classController.allClasses.forEach((classElement) {
        if (element.classId == classElement.classId) {
          _studentCount = classElement.studentCount;
          _courseId = classElement.courseId;
          _teacherName = classElement.employeeName;
          if (classElement.classLapOrNot == "0") {
            _theory = "class".tr + classElement.classNumber;
          } else {
            _lab = "labClass".tr + classElement.classNumber;
          }
          _courseName = classElement.arName;
        }
      });
      _class.studentCount = _studentCount;
      _class.courseId = _courseId;
      _class.teacher = _teacherName;
      _class.theory = _theory;
      _class.lab = _lab;
      _class.courseName = _courseName;
      _class.year = element.year;
      _class.semester = element.semester;
      _allPrograms.add(_class);
    });
    _allPrograms.sort((a, b) => a.courseId.compareTo(b.courseId));
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    double _height = SizeConfig().getScreenHeight(context);
    final List<Genes> _allGenes = genesFromJson(genesJson);
    List<Program> _allPrograms = <Program>[];
    intilaizeProgram(_allGenes, classController, _allPrograms);
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
          'semesterProgram'.tr,
          style: TextStyle(
              color: AppColor.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColor.green,
                ),
                onPressed: () {
                  //test if found any courses before opening
                  Program _title = Program();
                  _title.courseId = "courseId".tr;
                  _title.courseName = "courseName".tr;
                  _title.theory = "theroy".tr;
                  _title.lab = "lab".tr;
                  _title.studentCount = "studentCount".tr;
                  _title.year = "year".tr;
                  _title.semester = "semesterNumebr".tr;
                  _title.teacher = "teacherName".tr;
                  _title.time = "timeName".tr;
                  _title.day = "day".tr;
                  _allPrograms.insert(0, _title);
                  ExportCsv _csv = ExportCsv(data: _allPrograms);
                  _csv.downloadData();
                },
                child: Wrap(
                  children: <Widget>[
                    Icon(
                      Icons.download_rounded,
                      color: AppColor.white,
                      size: 24.0,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("csvConvert".tr,
                        style: TextStyle(fontSize: 20, color: AppColor.white)),
                  ],
                ),
              ),
            ),
            flex: 0,
          ),
          SizedBox(
            height: 10,
          ),
          Obx(() {
            if (isLoading.value == true) {
              return Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return Expanded(
                  child: Center(
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => AppColor.orange),
                      dataRowColor: MaterialStateColor.resolveWith(
                          (states) => AppColor.grayLight),
                      headingTextStyle:
                          TextStyle(color: AppColor.white, fontSize: 20),
                      dataTextStyle:
                          TextStyle(color: AppColor.black, fontSize: 16),
                      columns: [
                        DataColumn(label: Text('courseId'.tr)),
                        DataColumn(label: Text('courseName'.tr)),
                        DataColumn(label: Text('theroy'.tr)),
                        DataColumn(label: Text('lab'.tr)),
                        DataColumn(label: Text('studentCount'.tr)),
                        DataColumn(label: Text('day'.tr)),
                        DataColumn(label: Text('timeName'.tr)),
                        DataColumn(label: Text('teacherName'.tr)),
                        DataColumn(label: Text('year'.tr)),
                        DataColumn(label: Text('semesterNumebr'.tr)),
                      ],
                      rows: _allPrograms
                          .map((programItem) => DataRow(cells: [
                                DataCell(Text(programItem.courseId)),
                                DataCell(Text(programItem.courseName)),
                                DataCell(Text(programItem.theory)),
                                DataCell(Text(programItem.lab)),
                                DataCell(Text(programItem.studentCount)),
                                DataCell(Text(programItem.day)),
                                DataCell(Text(programItem.time)),
                                DataCell(Text(programItem.teacher)),
                                DataCell(Text(programItem.year)),
                                DataCell(Text(programItem.semester)),
                              ]))
                          .toList(),
                    ),
                  ),
                ),
              ));
            }
          }),
        ],
      ),
    );
  }
}
