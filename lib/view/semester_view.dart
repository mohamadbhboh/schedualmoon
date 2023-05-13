import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/component/app_color.dart';
import 'package:schedualmoon/component/confirm_dialog.dart';
import 'package:schedualmoon/component/size_config.dart';
import 'package:schedualmoon/controllers/app_responsive.dart';
import 'package:schedualmoon/controllers/drawer_controller.dart';
import 'package:schedualmoon/controllers/semester_controller.dart';
import 'package:schedualmoon/component/text_box.dart';
import 'package:schedualmoon/models/semester.dart';

class SemesterView extends StatelessWidget {
  final drawerController = Get.put(DrawerListController());
  final semesterController = Get.put(SemesterController());
  final GlobalKey<FormState> formValidEdit = new GlobalKey<FormState>();
  final GlobalKey<FormState> formValid = new GlobalKey<FormState>();
  final semesterTextController = new TextEditingController();
  final yearTextController = new TextEditingController();
  final semesterTextControllerAdd = new TextEditingController();
  final yearTextControllerAdd = new TextEditingController();
  final departmentId = Get.arguments[0];
  addSemester(String _name, String _year) {
    if (formValid.currentState!.validate()) {
      semesterController.addSemester(_year, _name);
    }
  }

  updateSemester(String id, String _newSemester, String _newYear) {
    if (formValidEdit.currentState!.validate()) {
      semesterController.updateSemester(id, _newSemester, _newYear);
    }
  }

  @override
  Widget build(BuildContext context) {
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
          'semesters'.tr,
          style: TextStyle(
              color: AppColor.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                //this section for add semester
                Row(
                  children: [
                    Expanded(
                      flex: 0,
                      child: Container(
                          child: IconButton(
                        icon: new Icon(Icons.add_circle_rounded),
                        iconSize: 50,
                        color: AppColor.blue,
                        tooltip: 'add'.tr,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    elevation: 0,
                                    backgroundColor: Colors.transparent,
                                    child: dialogContextAddSemester(context),
                                  ));
                        },
                      )),
                    ),
                  ],
                ),
                //end add semester
                SizedBox(
                  height: 20,
                ),
                //this section for view data
                Obx(() {
                  if (semesterController.isLoading.value == true) {
                    return Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: GridView.builder(
                          controller: ScrollController(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: AppResponsive.isDesktop(context)
                                ? 3
                                : AppResponsive.isTablet(context)
                                    ? 2
                                    : 1,
                          ),
                          itemCount: semesterController.allSemesters.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              margin: EdgeInsets.all(
                                  AppResponsive.isTablet(context) ? 20 : 50),
                              color: Colors.blueAccent,
                              elevation: 12,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              shadowColor: AppColor.orange,
                              child: Column(
                                children: [
                                  Center(
                                      child: Text(
                                    'semesterNumber'.tr +
                                        semesterController
                                            .allSemesters[index].semester,
                                    style: TextStyle(
                                        color: AppColor.white, fontSize: 20),
                                  )),
                                  SizedBox(
                                    height: AppResponsive.isMobile(context)
                                        ? 10
                                        : 30,
                                  ),
                                  Center(
                                    child: Text(
                                      'yearStudy'.tr +
                                          semesterController
                                              .allSemesters[index].year,
                                      style: TextStyle(
                                          color: AppColor.white, fontSize: 20),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: ListTile(
                                        title: Text('delete'.tr,
                                            style: TextStyle(
                                                color: AppColor.white,
                                                fontSize: 20)),
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  ConfirmDialog(
                                                    title: "deleteTitle".tr,
                                                    description:
                                                        "deleteDescription".tr,
                                                    positivePress: () {
                                                      Navigator.pop(context);
                                                      semesterController
                                                          .deleteSemester(
                                                              semesterController
                                                                  .allSemesters[
                                                                      index]
                                                                  .id);
                                                    },
                                                    cancelPrsee: () {
                                                      Navigator.pop(context);
                                                    },
                                                    icon: Icons.delete,
                                                    iconColor:
                                                        AppColor.redDelete,
                                                  ));
                                        },
                                        leading: Icon(
                                          Icons.delete_forever,
                                          color: AppColor.redDelete,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: ListTile(
                                        title: Text('update'.tr,
                                            style: TextStyle(
                                                color: AppColor.white,
                                                fontSize: 20)),
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16)),
                                                    elevation: 0,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    child:
                                                        dialogContextEditSemester(
                                                            context,
                                                            semesterController
                                                                    .allSemesters[
                                                                index]),
                                                  ));
                                        },
                                        leading: Icon(
                                          Icons.edit,
                                          color: AppColor.greenEdit,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: ListTile(
                                        title: Text('questionnaire'.tr,
                                            style: TextStyle(
                                                color: AppColor.white,
                                                fontSize: 20)),
                                        onTap: () {
                                          Semesters _semester =
                                              semesterController
                                                  .allSemesters[index];
                                          //TODO: replace this from login page
                                          Get.toNamed('/graduateStudent',
                                              arguments: [
                                                _semester.id,
                                                departmentId
                                              ]);
                                        },
                                        leading: Icon(
                                          Icons.question_answer_outlined,
                                          color: AppColor.greenEdit,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: ListTile(
                                        title: Text('semesterSetting'.tr,
                                            style: TextStyle(
                                                color: AppColor.white,
                                                fontSize: 20)),
                                        onTap: () {
                                          //TODO:get from login this element
                                          semesterController.allSemesters
                                              .refresh();
                                          String collegeId = departmentId;
                                          Semesters _semester =
                                              semesterController
                                                  .allSemesters[index];
                                          Get.toNamed('/employeeSemester',
                                              arguments: [
                                                collegeId,
                                                _semester
                                              ]);
                                        },
                                        leading: Icon(
                                          Icons.settings,
                                          color: AppColor.grayLight,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    );
                  }
                })
                //end view data
              ],
            ),
          )
        ],
      ),
    );
  }

  dialogContextEditSemester(BuildContext context, Semesters semesterItem) {
    semesterTextController.text = semesterItem.semester;
    yearTextController.text = semesterItem.year;
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
                "semesterEdit".tr,
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
                            //drop down time from
                            SizedBox(
                              height: 25,
                            ),

                            //end dropdown time from
                            SizedBox(
                              height: 25,
                            ),
                            Form(
                              key: formValidEdit,
                              child: Column(
                                children: [
                                  TextBox(
                                      isPassword: false,
                                      mxaLength: 1,
                                      name: 'semesterNumber'.tr,
                                      controllarName: semesterTextController,
                                      myicon: Icons.filter_1,
                                      inputvalid: (val) {
                                        if (val == "") {
                                          return "emptyString".tr;
                                        }
                                      },
                                      isNumber: true),
                                  TextBox(
                                      isPassword: false,
                                      mxaLength: 9,
                                      name: 'yearStudy'.tr,
                                      controllarName: yearTextController,
                                      myicon: Icons.calendar_today,
                                      inputvalid: (val) {
                                        if (val == "") {
                                          return "emptyString".tr;
                                        }
                                      },
                                      isNumber: false),
                                ],
                              ),
                            )
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
                          updateSemester(
                              semesterItem.id,
                              semesterTextController.text,
                              yearTextController.text);
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
              Icons.edit,
              size: 45,
              color: AppColor.white,
            ),
          ),
        )
      ],
    );
  }

  dialogContextAddSemester(BuildContext context) {
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
                "semesterAdd".tr,
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
                            //drop down time from
                            SizedBox(
                              height: 25,
                            ),

                            //end dropdown time from
                            SizedBox(
                              height: 25,
                            ),
                            Form(
                              key: formValid,
                              child: Column(
                                children: [
                                  TextBox(
                                      isPassword: false,
                                      mxaLength: 1,
                                      name: 'semesterNumber'.tr,
                                      controllarName: semesterTextControllerAdd,
                                      myicon: Icons.filter_1,
                                      inputvalid: (val) {
                                        if (val == "") {
                                          return "emptyString".tr;
                                        }
                                      },
                                      isNumber: true),
                                  TextBox(
                                      isPassword: false,
                                      mxaLength: 9,
                                      name: 'yearStudy'.tr,
                                      controllarName: yearTextControllerAdd,
                                      myicon: Icons.calendar_today,
                                      inputvalid: (val) {
                                        if (val == "") {
                                          return "emptyString".tr;
                                        }
                                      },
                                      isNumber: false),
                                ],
                              ),
                            )
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
                          addSemester(semesterTextControllerAdd.text,
                              yearTextControllerAdd.text);
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
