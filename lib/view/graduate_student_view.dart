import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/component/app_color.dart';
import 'package:schedualmoon/component/size_config.dart';
import 'package:schedualmoon/component/translations.dart';
import 'package:schedualmoon/controllers/course_controller.dart';
import 'package:schedualmoon/controllers/graduate_student_controller.dart';
import 'package:schedualmoon/controllers/student_controller.dart';
import 'package:schedualmoon/models/courses/base_courses.dart';
import 'package:schedualmoon/models/students.dart';

// ignore: must_be_immutable
class GraduateStudentView extends StatelessWidget {
  final departmentId = Get.arguments[1] as String;
  final semesterId = Get.arguments[0] as String;

  bool _search = false;
  @override
  Widget build(BuildContext context) {
    StudentController studentController =
        Get.put(StudentController(departmentId: departmentId));
    //this for graduate student to add course whe need only name, id from course
    CourseController.getGraduateCourses(departmentId);
    double _height = SizeConfig().getScreenHeight(context);
    final graduateStudentController = Get.put(GraduateStudentsController(
        departmentId: departmentId, semesterId: semesterId));
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
          'questionnaire'.tr,
          style: TextStyle(
              color: AppColor.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          //this section for search on student
          SizedBox(
            height: 20,
          ),
          Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Row(
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
                                      child: dialogAddGraduateStudent(
                                          context, studentController),
                                    ));
                          },
                          child: Wrap(
                            children: <Widget>[
                              Icon(
                                Icons.school,
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
                      ))
                ],
              )),
          Container(
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
                                        var result = graduateStudentController
                                            .allGraduateStudentBackup
                                            .where((element) =>
                                                element.name.contains(val))
                                            .toList();
                                        graduateStudentController
                                            .allGraduateStudent.value = result;
                                      },
                                      maxLength: 50,
                                      decoration: InputDecoration(
                                          hintText: 'studentName'.tr,
                                          hintStyle:
                                              TextStyle(color: AppColor.blue),
                                          border: InputBorder.none),
                                    ),
                            )),
                        Expanded(
                          flex: 0,
                          child: Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomRight:
                                      Radius.circular(_search ? 0 : 32),
                                  bottomLeft: Radius.circular(30),
                                  topRight: Radius.circular(_search ? 0 : 32)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(
                                  _search ? Icons.close : Icons.search,
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
          //end search on student
          SizedBox(
            height: 20,
          ),
          //this section for table
          Obx(() {
            if (graduateStudentController.isLoading.value == true ||
                CourseController.isLoadingBaseCourse.value == true ||
                studentController.isLoading.value == true) {
              return Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return Expanded(
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
                        DataColumn(label: Text('delete'.tr)),
                        DataColumn(
                          label: Text('studentNumber'.tr),
                          numeric: false,
                        ),
                        DataColumn(
                          label: Text('studentName'.tr),
                          numeric: false,
                        ),
                        DataColumn(
                          label: Text('courseId'.tr),
                          numeric: false,
                        ),
                        DataColumn(
                          label: Text('courseName'.tr),
                          numeric: false,
                        ),
                      ],
                      rows: graduateStudentController.allGraduateStudent
                          .map((studentElement) => DataRow(cells: [
                                DataCell(IconButton(
                                    onPressed: () {
                                      graduateStudentController
                                          .deleteGraduateQuestion(
                                              studentElement.questionId,
                                              studentElement.studentId);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: AppColor.redLight,
                                    ))),
                                DataCell(Text(studentElement.studentId)),
                                DataCell(Text(studentElement.name)),
                                DataCell(Text(studentElement.courseId)),
                                DataCell(Text(studentElement.arName))
                              ]))
                          .toList(),
                    ),
                  ),
                ),
              );
            }
          })
          //end section for table
        ],
      ),
    );
  }

  //this dialog to add student with graduate course
  dialogAddGraduateStudent(
      BuildContext context, StudentController studentController) {
    BaseCourses selectedCourse = CourseController.allBaseCourses[0];
    Students selectedStudent = studentController.allStudents[0];
    Translation translation = Translation();
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
                "addStudentCourse".tr,
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
                                  labelText: "selectCourse".tr,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: AppColor.orange, width: 2)),
                                  labelStyle: TextStyle(
                                      color: AppColor.black, fontSize: 20)),
                              value: selectedCourse,
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              onChanged: (BaseCourses? newValue) {
                                setState(() {
                                  selectedCourse = newValue!;
                                });
                              },
                              items: CourseController.allBaseCourses
                                  .map<DropdownMenuItem<BaseCourses>>(
                                      (BaseCourses value) {
                                return DropdownMenuItem<BaseCourses>(
                                  value: value,
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          value.id,
                                          style: TextStyle(
                                              color: AppColor.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          translation.selectedLanguage.value ==
                                                  "ar"
                                              ? value.arabicName
                                              : value.englishName,
                                          style:
                                              TextStyle(color: AppColor.black),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
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
                              value: selectedStudent,
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              onChanged: (Students? newValue) {
                                setState(() {
                                  selectedStudent = newValue!;
                                });
                              },
                              items: studentController.allStudents
                                  .map<DropdownMenuItem<Students>>(
                                      (Students value) {
                                return DropdownMenuItem<Students>(
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
                          //TODO: Add Course-Student
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
                Icons.school,
                size: 45,
                color: AppColor.white,
              ),
            ))
      ],
    );
  }
}
