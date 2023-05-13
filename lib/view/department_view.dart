import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/component/app_color.dart';
import 'package:schedualmoon/component/confirm_dialog.dart';
import 'package:schedualmoon/component/drawer.dart';
import 'package:schedualmoon/component/text_box.dart';
import 'package:schedualmoon/controllers/app_responsive.dart';
import 'package:schedualmoon/controllers/college_controller.dart';
import 'package:schedualmoon/controllers/department_controller.dart';
import 'package:schedualmoon/controllers/drawer_controller.dart';
import 'package:schedualmoon/models/colleges.dart';
import 'package:schedualmoon/models/departments.dart';

// ignore: must_be_immutable
class DepartmentView extends StatelessWidget {
  final drawerController = Get.put(DrawerListController());
  final departmentController = Get.put(DepartmentController());
  final departmentNameController = new TextEditingController();
  final GlobalKey<FormState> formValid = new GlobalKey<FormState>();
  final departmentNameControllerEdit = new TextEditingController();
  final GlobalKey<FormState> formValidEdit = new GlobalKey<FormState>();
  bool _search = false;

  addDepartment(Colleges collegeItem, String name) {
    if (formValid.currentState!.validate()) {
      departmentController.addDepartment(
          name, collegeItem.id, collegeItem.name);
    }
  }

  updateDepartment(Colleges _college, int departmentId, String departmentName) {
    if (formValidEdit.currentState!.validate()) {
      departmentController.updateDepartment(
          departmentId, departmentName, _college.id, _college.name);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                //this section for search
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
                                    child: dialogContextAddDepartment(context),
                                  ));
                        },
                      )),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
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
                                                    var result =
                                                        departmentController
                                                            .allDepartmentsBackup
                                                            .where((element) =>
                                                                element
                                                                    .name
                                                                    .contains(
                                                                        val) ||
                                                                element
                                                                    .collegeName
                                                                    .contains(
                                                                        val))
                                                            .toList();
                                                    departmentController
                                                        .allDepartments
                                                        .value = result;
                                                  },
                                                  maxLength: 50,
                                                  decoration: InputDecoration(
                                                      hintText: 'nameInput'.tr,
                                                      hintStyle: TextStyle(
                                                          color: AppColor.blue),
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
                                              bottomRight: Radius.circular(
                                                  _search ? 0 : 32),
                                              bottomLeft: Radius.circular(30),
                                              topRight: Radius.circular(
                                                  _search ? 0 : 32)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
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
                    ),
                  ],
                ),
                //end search
                SizedBox(
                  height: 20,
                ),
                //this section to view data
                Obx(() {
                  if (departmentController.isLoading.value == true) {
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
                            sortColumnIndex: 0,
                            columns: [
                              DataColumn(label: Text('update'.tr)),
                              DataColumn(label: Text('delete'.tr)),
                              DataColumn(
                                  label: Text('departmentId'.tr),
                                  numeric: true),
                              DataColumn(label: Text('departmentName'.tr)),
                              DataColumn(label: Text('deptCollegeName'.tr))
                            ],
                            rows: departmentController.allDepartments
                                .map((departmentItem) => DataRow(cells: [
                                      DataCell(IconButton(
                                          onPressed: () {
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
                                                          dialogContextUpdateDepartment(
                                                              context,
                                                              departmentItem),
                                                    ));
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: AppColor.greenEdit,
                                          ))),
                                      DataCell(IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    ConfirmDialog(
                                                      title: "deleteTitle".tr,
                                                      description:
                                                          "deleteDescription"
                                                              .tr,
                                                      positivePress: () async {
                                                        departmentController
                                                            .deleteDepartment(
                                                                departmentItem
                                                                    .id);
                                                        Navigator.pop(context);
                                                      },
                                                      cancelPrsee: () {
                                                        Navigator.pop(context);
                                                      },
                                                      icon: Icons.delete,
                                                      iconColor: AppColor.white,
                                                    ));
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: AppColor.redLight,
                                          ))),
                                      DataCell(
                                          Text(departmentItem.id.toString())),
                                      DataCell(Text(departmentItem.name)),
                                      DataCell(Text(departmentItem.collegeName))
                                    ]))
                                .toList(),
                          ),
                        ),
                      ),
                    );
                  }
                })
                //end view  data
              ],
            ),
          )
        ],
      ),
    );
  }

  dialogContextAddDepartment(BuildContext context) {
    CollegesController collegesController = Get.put(CollegesController());
    Colleges collegeValue;
    departmentNameController.text = "";
    return Obx(() {
      if (collegesController.isLoading.value == true) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        collegeValue = collegesController.allColleges[0];
        return Stack(
          children: [
            Container(
              width: 450,
              padding:
                  EdgeInsets.only(top: 100, bottom: 16, left: 16, right: 16),
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
                    "addDepartment".tr,
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
                                DropdownButtonFormField(
                                  decoration: InputDecoration(
                                      labelText: "deptCollegeName".tr,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color: AppColor.orange,
                                              width: 2)),
                                      labelStyle: TextStyle(
                                          color: AppColor.black, fontSize: 20)),
                                  value: collegeValue,
                                  iconSize: 24,
                                  elevation: 16,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  onChanged: (Colleges? newValue) {
                                    setState(() {
                                      collegeValue = newValue!;
                                    });
                                  },
                                  items: collegesController.allColleges
                                      .map<DropdownMenuItem<Colleges>>(
                                          (Colleges value) {
                                    return DropdownMenuItem<Colleges>(
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
                                Form(
                                  key: formValid,
                                  child: TextBox(
                                      isPassword: false,
                                      mxaLength: 35,
                                      name: 'departmentName'.tr,
                                      controllarName: departmentNameController,
                                      myicon: Icons.splitscreen,
                                      inputvalid: (val) {
                                        if (val == "") {
                                          return "emptyString".tr;
                                        }
                                      },
                                      isNumber: false),
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
                              addDepartment(
                                  collegeValue, departmentNameController.text);
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
    });
  }

  dialogContextUpdateDepartment(BuildContext context, Departments _department) {
    CollegesController collegesController = Get.put(CollegesController());
    Colleges collegeValue;
    departmentNameControllerEdit.text = _department.name;
    return Obx(() {
      if (collegesController.isLoading.value == true) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        collegeValue = collegesController.allColleges
            .where((element) => element.id == _department.collegeId.toString())
            .toList()[0];
        return Stack(
          children: [
            Container(
              width: 450,
              padding:
                  EdgeInsets.only(top: 100, bottom: 16, left: 16, right: 16),
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
                    "addDepartment".tr,
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
                                DropdownButtonFormField(
                                  decoration: InputDecoration(
                                      labelText: "deptCollegeName".tr,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color: AppColor.orange,
                                              width: 2)),
                                      labelStyle: TextStyle(
                                          color: AppColor.black, fontSize: 20)),
                                  value: collegeValue,
                                  iconSize: 24,
                                  elevation: 16,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  onChanged: (Colleges? newValue) {
                                    setState(() {
                                      collegeValue = newValue!;
                                    });
                                  },
                                  items: collegesController.allColleges
                                      .map<DropdownMenuItem<Colleges>>(
                                          (Colleges value) {
                                    return DropdownMenuItem<Colleges>(
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
                                Form(
                                  key: formValidEdit,
                                  child: TextBox(
                                      isPassword: false,
                                      mxaLength: 35,
                                      name: 'departmentName'.tr,
                                      controllarName:
                                          departmentNameControllerEdit,
                                      myicon: Icons.splitscreen,
                                      inputvalid: (val) {
                                        if (val == "") {
                                          return "emptyString".tr;
                                        }
                                      },
                                      isNumber: false),
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
                              updateDepartment(collegeValue, _department.id,
                                  departmentNameControllerEdit.text);
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
    });
  }
}
