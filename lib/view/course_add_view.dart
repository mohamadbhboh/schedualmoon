import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/component/app_color.dart';
import 'package:schedualmoon/component/size_config.dart';
import 'package:schedualmoon/controllers/app_responsive.dart';
import 'package:schedualmoon/controllers/course_controller.dart';
import 'package:schedualmoon/controllers/department_controller.dart';
import 'package:schedualmoon/models/courses/courses.dart';
import 'package:schedualmoon/models/departments.dart';
import 'package:schedualmoon/component/text_box.dart';

// ignore: must_be_immutable
class CourseAddView extends StatelessWidget {
  int semesterValue = 0;
  final courseController = Get.put(CourseController());
  //this to get departments for selection departments
  final departmentController = Get.put(DepartmentController());
  //end get colleges
  final courseIdController = new TextEditingController();
  final courseNameController = new TextEditingController();
  final courseEnNameController = new TextEditingController();
  final courseToHourController = new TextEditingController();
  final courseThHourController = new TextEditingController();
  final courseLapHourController = new TextEditingController();
  final courseYearController = new TextEditingController();
  final GlobalKey<FormState> formValid = new GlobalKey<FormState>();
  final allSemester = <int>[0, 1, 2];
  addCourse(Departments departmentValue) {
    if (formValid.currentState!.validate()) {
      Courses _newCourse = Courses(
          id: courseIdController.text,
          departmentId: departmentValue.id,
          arabicName: courseNameController.text,
          englishName: courseEnNameController.text,
          totalHour: int.parse(courseThHourController.text),
          theoriticalHour: int.parse(courseThHourController.text),
          labHour: int.parse(courseLapHourController.text),
          year: int.parse(courseYearController.text),
          semester: semesterValue,
          departmentName: departmentValue.name);
      courseController.addCourse(_newCourse);
    }
  }

  @override
  Widget build(BuildContext context) {
    double _height = SizeConfig().getScreenHeight(context);
    Departments departmentValue;
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
            'courseAdd'.tr,
            style: TextStyle(
                color: AppColor.white,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/schedual_textminop.png'),
                    fit: BoxFit.fill),
              ),
            ),
            Obx(() {
              if (departmentController.isLoading.value == true)
                return Center(
                  child: CircularProgressIndicator(),
                );
              else {
                //fill alldepartments
                departmentValue = departmentController.allDepartments[0];
                return Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    width:
                        AppResponsive.isMobile(context) ? double.infinity : 450,
                    child: Form(
                        key: formValid,
                        child: ListView(
                          children: [
                            //add update element
                            SizedBox(
                              height: 10,
                            ),
                            TextBox(
                                isPassword: false,
                                mxaLength: 10,
                                name: 'courseId'.tr,
                                controllarName: courseIdController,
                                myicon: Icons.vpn_key_rounded,
                                inputvalid: (value) {
                                  if (value == "") {
                                    return 'النص فارغ';
                                  }
                                },
                                isNumber: false),
                            TextBox(
                                isPassword: false,
                                mxaLength: 50,
                                name: 'arabicName'.tr,
                                controllarName: courseNameController,
                                myicon: Icons.text_snippet,
                                inputvalid: (value) {
                                  if (value == "") {
                                    return 'النص فارغ';
                                  }
                                },
                                isNumber: false),
                            TextBox(
                                isPassword: false,
                                mxaLength: 50,
                                name: 'englishName'.tr,
                                controllarName: courseEnNameController,
                                myicon: Icons.text_snippet,
                                inputvalid: (value) {
                                  if (value == "") {
                                    return 'النص فارغ';
                                  }
                                },
                                isNumber: false),
                            TextBox(
                                isPassword: false,
                                mxaLength: 2,
                                name: 'totalHour'.tr,
                                controllarName: courseToHourController,
                                myicon: Icons.plus_one_sharp,
                                inputvalid: (value) {
                                  if (value == "") {
                                    return 'النص فارغ';
                                  }
                                },
                                isNumber: true),
                            TextBox(
                                isPassword: false,
                                mxaLength: 2,
                                name: 'theoriticalHour'.tr,
                                controllarName: courseThHourController,
                                myicon: Icons.plus_one_outlined,
                                inputvalid: (value) {
                                  if (value == "") {
                                    return 'النص فارغ';
                                  }
                                },
                                isNumber: true),
                            TextBox(
                                isPassword: false,
                                mxaLength: 2,
                                name: 'labHour'.tr,
                                controllarName: courseLapHourController,
                                myicon: Icons.plus_one_outlined,
                                inputvalid: (value) {
                                  if (value == "") {
                                    return 'النص فارغ';
                                  }
                                },
                                isNumber: true),
                            TextBox(
                                isPassword: false,
                                mxaLength: 1,
                                name: 'year'.tr,
                                controllarName: courseYearController,
                                myicon: Icons.plus_one,
                                inputvalid: (value) {
                                  if (value == "") {
                                    return 'النص فارغ';
                                  }
                                },
                                isNumber: true),
                            StatefulBuilder(
                              builder: (BuildContext context, setState) {
                                return Column(
                                  children: [
                                    DropdownButtonFormField(
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
                                      onChanged: (Departments? newValue) {
                                        setState(() {
                                          departmentValue = newValue!;
                                        });
                                      },
                                      items: departmentController.allDepartments
                                          .map<DropdownMenuItem<Departments>>(
                                              (Departments value) {
                                        return DropdownMenuItem<Departments>(
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
                                    SizedBox(
                                      height: 20,
                                    ),
                                    DropdownButtonFormField(
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
                                      onChanged: (int? newValue) {
                                        setState(() {
                                          semesterValue = newValue!;
                                        });
                                      },
                                      items: allSemester
                                          .map<DropdownMenuItem<int>>(
                                              (int value) {
                                        return DropdownMenuItem<int>(
                                          value: value,
                                          child: Center(
                                            child: Text(
                                              value.toString(),
                                              style: TextStyle(
                                                  color: AppColor.blue,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                        child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: AppColor.lighteOrange,
                                      ),
                                      onPressed: () {
                                        addCourse(departmentValue);
                                      },
                                      child: Wrap(
                                        children: <Widget>[
                                          Icon(
                                            Icons.add,
                                            color: AppColor.bluelight,
                                            size: 24.0,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text("add".tr,
                                              style: TextStyle(fontSize: 20)),
                                        ],
                                      ),
                                    )),
                                    SizedBox(
                                      height: 20,
                                    )
                                  ],
                                );
                              },
                            ),
                            //end update  element
                          ],
                        )),
                  ),
                );
              }
            })
          ],
        ));
  }
}
