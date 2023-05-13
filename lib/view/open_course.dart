import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:schedualmoon/component/app_color.dart';
import 'package:schedualmoon/component/size_config.dart';
import 'package:schedualmoon/controllers/app_responsive.dart';
import 'package:schedualmoon/controllers/class_controller.dart';
import 'package:schedualmoon/controllers/open_course_controller.dart';
import 'package:schedualmoon/models/courses/courses.dart';
import 'package:schedualmoon/component/text_box.dart';
import 'package:schedualmoon/models/open_course.dart';
import 'package:schedualmoon/models/semester.dart';
import 'package:schedualmoon/models/teach_hour.dart';
import 'package:schedualmoon/models/teaching_matrix_menu_item.dart';

class OpenCourse extends StatelessWidget {
  final classController = Get.arguments[0] as ClassController;
  final semester = Get.arguments[1] as Semesters;
  final departmentId = Get.arguments[2] as String;
  final courseTheoryNumber = new TextEditingController();
  final courseLabController = new TextEditingController();
  final classNumberController = new TextEditingController();
  final studentCountController = new TextEditingController();
  final GlobalKey<FormState> formValid = new GlobalKey<FormState>();
  final openCourseController = Get.put(OpenCourseController());
  @override
  Widget build(BuildContext context) {
    Category _category = Category();
    List<String> dropDownClasses = <String>[];
    var showClassesTool = false.obs;
    double _height = SizeConfig().getScreenHeight(context);
    Courses speceficCourse = classController.departmentCoursesNotOpening[0];
    String classOrLabClass = "";
    TeachingMatrixMenuItem _employeeItem =
        TeachingMatrixMenuItem(employeeId: "", employeeName: "");
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
              color: AppColor.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: StatefulBuilder(
        builder: (BuildContext context, setState) {
          return Center(
            child: Container(
              width: AppResponsive.isMobile(context) ? double.infinity : 450,
              margin: EdgeInsets.only(top: 20),
              child: Form(
                  key: formValid,
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                            labelText: "selectCourse".tr,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: AppColor.orange, width: 2)),
                            labelStyle:
                                TextStyle(color: AppColor.black, fontSize: 20)),
                        value: speceficCourse,
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        onChanged: (Courses? newValue) {
                          setState(() {
                            speceficCourse = newValue!;
                          });
                        },
                        items: classController.departmentCoursesNotOpening
                            .map<DropdownMenuItem<Courses>>((Courses value) {
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
                      //number of classes
                      TextBox(
                          isPassword: false,
                          mxaLength: 2,
                          name: 'theoryCount'.tr,
                          controllarName: courseTheoryNumber,
                          myicon: Icons.filter_1,
                          inputvalid: (value) {
                            if (value == "") {
                              return 'النص فارغ';
                            }
                          },
                          isNumber: true),
                      //number of labs
                      SizedBox(
                        height: 25,
                      ),
                      //number of lab
                      TextBox(
                          isPassword: false,
                          mxaLength: 2,
                          name: 'labCount'.tr,
                          controllarName: courseLabController,
                          myicon: Icons.filter_1,
                          inputvalid: (value) {
                            if (value == "") {
                              return 'النص فارغ';
                            }
                          },
                          isNumber: true),
                      //this elements  realtion with classes data

                      //\elements classes data
                      SizedBox(
                        height: 25,
                      ),

                      //this to select classes
                      Visibility(
                        visible: showClassesTool.value,
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                              labelText: "selectClassorLab".tr,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: AppColor.orange, width: 2)),
                              labelStyle: TextStyle(
                                  color: AppColor.black, fontSize: 20)),
                          value: classOrLabClass,
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          onChanged: (String? newValue) {
                            setState(() {
                              classOrLabClass = newValue!;
                            });
                          },
                          items: dropDownClasses
                              .map<DropdownMenuItem<String>>((String value) {
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
                      Visibility(
                        visible: showClassesTool.value,
                        child: SizedBox(
                          height: 25,
                        ),
                      ),
                      Visibility(
                        visible: showClassesTool.value,
                        child: TextBox(
                            isPassword: false,
                            mxaLength: 2,
                            name: 'studentCount'.tr,
                            controllarName: studentCountController,
                            myicon: Icons.filter_1,
                            inputvalid: (value) {
                              if (value == "") {
                                return 'النص فارغ';
                              }
                            },
                            isNumber: true),
                      ),
                      Visibility(
                        child: SizedBox(
                          height: 25,
                        ),
                        visible: showClassesTool.value,
                      ),
                      Visibility(
                        visible: showClassesTool.value,
                        child: //class number
                            TextBox(
                                isPassword: false,
                                mxaLength: 2,
                                name: 'classNumber'.tr,
                                controllarName: classNumberController,
                                myicon: Icons.filter_1,
                                inputvalid: (value) {
                                  if (value == "") {
                                    return 'النص فارغ';
                                  }
                                },
                                isNumber: true),
                      ),
                      //end class number
                      //this section for employee selection
                      Visibility(
                        child: SizedBox(
                          height: 25,
                        ),
                        visible: showClassesTool.value,
                      ),
                      Obx(() {
                        if (!showClassesTool.value) {
                          return Visibility(child: Container());
                        } else {
                          List<TeachingMatrixMenuItem> _courseTeachers =
                              <TeachingMatrixMenuItem>[];
                          //if course is an theoriticl course need to tteaching matrix
                          if (classOrLabClass.contains('class'.tr)) {
                            var _allCourseTeachers = classController
                                .allDepartmentTeachingMatrix
                                .where((item) =>
                                    item.courseId == speceficCourse.id)
                                .toList();
                            classController.allDepartmentTeachingMatrix
                                .forEach((element) {});
                            _allCourseTeachers.forEach((element) {
                              TeachingMatrixMenuItem _menuItem =
                                  TeachingMatrixMenuItem(
                                      employeeId: element.employeeId,
                                      employeeName: element.name);
                              _courseTeachers.add(_menuItem);
                            });
                          } else {
                            classController.allDepartmentsEmployee
                                .forEach((element) {
                              _courseTeachers.add(element);
                            });
                          }
                          TeachingMatrixMenuItem _specificItem =
                              _courseTeachers[0];
                          _employeeItem = _specificItem;
                          //return Dropdown button
                          return StatefulBuilder(
                            builder: (BuildContext context, setState) {
                              return DropdownButtonFormField(
                                decoration: InputDecoration(
                                    labelText: "selectTeacher".tr,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                            color: AppColor.orange, width: 2)),
                                    labelStyle: TextStyle(
                                        color: AppColor.black, fontSize: 20)),
                                value: _specificItem,
                                iconSize: 24,
                                elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                onChanged: (TeachingMatrixMenuItem? newValue) {
                                  setState(() {
                                    _specificItem = newValue!;
                                    _employeeItem = _specificItem;
                                  });
                                },
                                items: _courseTeachers.map<
                                        DropdownMenuItem<
                                            TeachingMatrixMenuItem>>(
                                    (TeachingMatrixMenuItem value) {
                                  return DropdownMenuItem<
                                      TeachingMatrixMenuItem>(
                                    value: value,
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Text(
                                            value.employeeName,
                                            style: TextStyle(
                                                color: AppColor.blue,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Center(
                                            child: LinearPercentIndicator(
                                              width: 150,
                                              percent: getPercentage(
                                                  int.parse(value.employeeId)),
                                              lineHeight: 18,
                                              backgroundColor:
                                                  AppColor.grayLight,
                                              progressColor: getPercentage(
                                                          int.parse(value
                                                              .employeeId)) <
                                                      0.75
                                                  ? AppColor.green
                                                  : AppColor.red,
                                              center: Text(getTeachHour(
                                                          int.parse(
                                                              value.employeeId))
                                                      .hourClasses
                                                      .toString() +
                                                  "/" +
                                                  getTeachHour(int.parse(
                                                          value.employeeId))
                                                      .hourNumber
                                                      .toString()),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          );
                        }
                      }),
                      //end employee selection
                      //end tool classes
                      Visibility(
                        child: SizedBox(
                          height: 25,
                        ),
                        visible: showClassesTool.value,
                      ),
                      //buttons
                      Row(
                        children: [
                          Visibility(
                            visible: showClassesTool.value,
                            child: Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: AppColor.greenEdit,
                                  ),
                                  onPressed: () {
                                    //insert class or lab class
                                    if (formValid.currentState!.validate()) {
                                      ClassCategory _classCategoryItem =
                                          _category.allClasses
                                              .where((element) =>
                                                  element.classCategoryId ==
                                                  classOrLabClass)
                                              .toList()[0];
                                      _classCategoryItem.studentCount =
                                          int.parse(
                                              studentCountController.text);
                                      _classCategoryItem.classNumber =
                                          int.parse(classNumberController.text);
                                      _classCategoryItem.employeeId =
                                          _employeeItem.employeeId;
                                    }
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
                                      Text("confirm".tr,
                                          style: TextStyle(fontSize: 20)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //this button for send request to server
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: AppColor.lighteOrange,
                                ),
                                onPressed: () {
                                  if (!showClassesTool.value) {
                                    if (formValid.currentState!.validate()) {
                                      int theoryCount =
                                          int.parse(courseTheoryNumber.text);
                                      int labCount =
                                          int.parse(courseLabController.text);
                                      if (theoryCount == 0) {
                                        EasyLoading.showError(
                                            'errorTheoryNumber'.tr);
                                      } else {
                                        setState(() {
                                          //create Category object
                                          _category = Category();
                                          _category.courseId =
                                              speceficCourse.id;
                                          _category.semesterId =
                                              int.parse(semester.id);
                                          _category.departmentId =
                                              int.parse(departmentId);
                                          //intilaize this for dropdown button
                                          classOrLabClass =
                                              "class".tr + 1.toString();
                                          for (int i = 1;
                                              i <= theoryCount;
                                              i++) {
                                            String element =
                                                "class".tr + i.toString();
                                            //first add element to drop down menu
                                            dropDownClasses.add(element);
                                            ClassCategory _classCategory =
                                                ClassCategory();
                                            _classCategory.lapOrNot = 0;
                                            _classCategory.classCategoryId =
                                                element;
                                            _classCategory.hourNumber =
                                                speceficCourse.theoriticalHour;
                                            _category.allClasses
                                                .add(_classCategory);
                                          }
                                          for (int i = 1; i <= labCount; i++) {
                                            String element =
                                                "labClass".tr + i.toString();
                                            //first add element to drop down menu
                                            dropDownClasses.add(element);
                                            ClassCategory _classCategory =
                                                ClassCategory();
                                            _classCategory.lapOrNot = 1;
                                            _classCategory.classCategoryId =
                                                element;
                                            _classCategory.hourNumber =
                                                speceficCourse.labHour;
                                            _category.allClasses
                                                .add(_classCategory);
                                          }
                                          showClassesTool.value = true;
                                          EasyLoading.showInfo(
                                              'classesInfo'.tr);
                                        });
                                      }
                                    }
                                  } else {
                                    //first : must validation all data is ready
                                    bool valid = true;
                                    for (int i = 1;
                                        i <= _category.allClasses.length;
                                        i++) {
                                      if (_category.allClasses[i - 1]
                                                  .employeeId ==
                                              "" ||
                                          _category.allClasses[i - 1]
                                                  .studentCount ==
                                              0) {
                                        valid = false;
                                        EasyLoading.showError(
                                            "pleaseEnterInfo".tr +
                                                " " +
                                                _category.allClasses[i]
                                                    .classCategoryId +
                                                " " +
                                                "trueFormat".tr);
                                        break;
                                      }
                                    }
                                    if (valid) {
                                      openCourseController.openCourse(
                                          categoryToJson(_category),
                                          classController);
                                    }
                                  }
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
                                    Text("add".tr,
                                        style: TextStyle(fontSize: 20)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          //this button for reset all element
                          Visibility(
                            visible: showClassesTool.value,
                            child: Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: AppColor.red,
                                  ),
                                  onPressed: () {
                                    //insert class or lab class
                                    setState(() {
                                      _category = Category();
                                      courseTheoryNumber.text = "";
                                      courseLabController.text = "";
                                      classNumberController.text = "";
                                      studentCountController.text = "";
                                      classOrLabClass = "";
                                      showClassesTool.value = false;
                                      dropDownClasses.clear();
                                    });
                                  },
                                  child: Wrap(
                                    children: <Widget>[
                                      Icon(
                                        Icons.settings_backup_restore,
                                        color: AppColor.bluelight,
                                        size: 24.0,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("reset".tr,
                                          style: TextStyle(fontSize: 20)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //end button reset
                        ],
                      ),
                      //\btn
                      //end lab
                      Visibility(
                        child: SizedBox(
                          height: 25,
                        ),
                        visible: showClassesTool.value,
                      ),
                    ],
                  )),
            ),
          );
        },
      ),
    );
  }

  double getPercentage(int employeeId) {
    TeachHour _teachHour = classController.allTeachHour
        .where((item) => item.employeeId == employeeId)
        .toList()[0];
    double percentage = _teachHour.hourClasses / _teachHour.hourNumber;
    if (percentage > 1) percentage = 1;
    return percentage;
  }

  TeachHour getTeachHour(int employeeId) {
    TeachHour _teachHour = classController.allTeachHour
        .where((item) => item.employeeId == employeeId)
        .toList()[0];
    return _teachHour;
  }
}
