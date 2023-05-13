import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:schedualmoon/component/app_color.dart';
import 'package:schedualmoon/component/size_config.dart';

import 'package:schedualmoon/controllers/employee_controller.dart';

import 'package:schedualmoon/models/employees.dart';
import 'package:schedualmoon/models/jobRankDepartmentmodel.dart';

class UpdateEmployee extends StatelessWidget {
  final jobRankDepartmentController = Get.put(EmployeesController());
  final GlobalKey<FormState> formValidEdit = new GlobalKey<FormState>();

  Widget build(BuildContext context) {
    double _height = SizeConfig().getScreenHeight(context);
    Employees data = Get.arguments as Employees;
    List<String> allJobs = [];
    List<String> allRanks = [];
    List<String> allDepartment = [];

    jobRankDepartmentController.allJobRankDepartments.jobs.forEach((element) {
      allJobs.add(element.name);
    });
    jobRankDepartmentController.allJobRankDepartments.ranks.forEach((element) {
      allRanks.add(element.name);
    });
    jobRankDepartmentController.allJobRankDepartments.department
        .forEach((element) {
      allDepartment.add(element.name);
    });

    final employeeNameContorlar = new TextEditingController();

    bool iscontracted;
    bool memberShipteaching;
    bool isAdmin;

    final rankNameContorlar = new TextEditingController();
    final jobNameContorlar = new TextEditingController();
    employeeNameContorlar.text = data.name;

    updateEmployee(
        Employees item,
        String name,
        String departmentId,
        String rankId,
        String jobId,
        String type,
        String contracted,
        String password,
        String employeeMembership,
        BuildContext context) {
      if (formValidEdit.currentState!.validate()) {
        jobRankDepartmentController.updateEmployee(
            item,
            name,
            departmentId,
            rankId,
            jobId,
            type,
            contracted,
            password,
            employeeMembership,
            context);
      }
    }

    rankNameContorlar.text = data.rankName;
    jobNameContorlar.text = data.jobName;
    if (data.contracted == "1") {
      iscontracted = true;
    } else {
      iscontracted = false;
    }
    if (data.employeeMembership == "1") {
      memberShipteaching = true;
    } else {
      memberShipteaching = false;
    }
    if (data.type == "1") {
      isAdmin = true;
    } else {
      isAdmin = false;
    }
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
            'UpdateEmployeeDate'.tr,
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
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColor.white,
                    AppColor.syan,
                    AppColor.lighteblue,
                    AppColor.blueAvg,
                  ],
                  stops: [
                    0.2,
                    0.6,
                    0.8,
                    1,
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                width: 400,
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 8,
                    right: MediaQuery.of(context).size.width / 8,
                    top: 40),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  controller: ScrollController(),
                  child: Form(
                    key: formValidEdit,
                    child: Column(
                      children: [
                        TextFormField(
                          style: TextStyle(
                              color: AppColor.blue,
                              fontWeight: FontWeight.bold),
                          maxLength: 50,
                          controller: employeeNameContorlar,
                          textAlign: TextAlign.center,
                          validator: (value) {
                            if (value == "") {
                              return 'Text Is Empty';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: "employeeName".tr,
                              labelStyle: TextStyle(color: AppColor.black),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                    color: AppColor.orange, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(color: AppColor.orange),
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        StatefulBuilder(
                          builder: (BuildContext context, setState) {
                            return DropdownButtonFormField(
                                decoration: InputDecoration(
                                    labelText: "departmentName".tr,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                            color: AppColor.orange, width: 2)),
                                    labelStyle: TextStyle(
                                        color: AppColor.black, fontSize: 20)),
                                value: data.departmentName,
                                iconSize: 24,
                                elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                onChanged: (newValue) {
                                  setState(() {
                                    data.departmentName = newValue!.toString();
                                  });
                                },
                                items: allDepartment
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
                                }).toList());
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        StatefulBuilder(
                          builder: (BuildContext context, setState) {
                            return DropdownButtonFormField(
                                decoration: InputDecoration(
                                    labelText: "jobName".tr,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                            color: AppColor.orange, width: 2)),
                                    labelStyle: TextStyle(
                                        color: AppColor.black, fontSize: 20)),
                                value: data.jobName,
                                iconSize: 24,
                                elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                onChanged: (newValue) {
                                  setState(() {
                                    data.jobName = newValue!.toString();
                                  });
                                },
                                items: allJobs.map<DropdownMenuItem<String>>(
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
                                }).toList());
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        StatefulBuilder(
                          builder: (BuildContext context, setState) {
                            return DropdownButtonFormField(
                                decoration: InputDecoration(
                                    labelText: "rankName".tr,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                            color: AppColor.orange, width: 2)),
                                    labelStyle: TextStyle(
                                        color: AppColor.black, fontSize: 20)),
                                value: data.rankName,
                                iconSize: 24,
                                elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                onChanged: (newValue) {
                                  setState(() {
                                    data.rankName = newValue!.toString();
                                  });
                                },
                                items: allRanks.map<DropdownMenuItem<String>>(
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
                                }).toList());
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        StatefulBuilder(
                          builder: (BuildContext context, setState) {
                            return CheckboxListTile(
                              title: Text("isContracted".tr),
                              value: iscontracted,
                              onChanged: (newValue) {
                                setState(() {
                                  if (newValue == true) {
                                    iscontracted = true;
                                  } else {
                                    iscontracted = false;
                                  }
                                });
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        StatefulBuilder(
                          builder: (BuildContext context, setState) {
                            return CheckboxListTile(
                              title: Text("membershipTrue".tr),
                              value: memberShipteaching,
                              onChanged: (newValue) {
                                setState(() {
                                  memberShipteaching = newValue as bool;
                                });
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        StatefulBuilder(
                          builder: (BuildContext context, setState) {
                            return CheckboxListTile(
                              title: Text("typeTrue".tr),
                              value: isAdmin,
                              onChanged: (newValue) {
                                setState(() {
                                  if (newValue == true) {
                                    isAdmin = true;
                                  } else {
                                    isAdmin = false;
                                  }
                                });
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                            child: Container(
                                width: 150,
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      var employeeMembership;
                                      var contracted;
                                      var type;
                                      Job? jobitem;
                                      Rank? rankitem;
                                      Department? departmentitem;

                                      jobRankDepartmentController
                                          .allJobRankDepartments.ranks
                                          .forEach((element) {
                                        if (element.name == data.rankName) {
                                          rankitem = element;
                                        }
                                      }) as Rank;
                                      jobRankDepartmentController
                                          .allJobRankDepartments.jobs
                                          .forEach((element) {
                                        if (element.name == data.jobName) {
                                          jobitem = element;
                                        }
                                      }) as Job;

                                      jobRankDepartmentController
                                          .allJobRankDepartments.department
                                          .forEach((element) {
                                        if (element.name ==
                                            data.departmentName) {
                                          departmentitem = element;
                                        }
                                      }) as Department;

                                      if (memberShipteaching == true) {
                                        employeeMembership = "1";
                                      } else {
                                        employeeMembership = "0";
                                      }
                                      if (iscontracted == true) {
                                        contracted = "1";
                                      } else {
                                        contracted = "0";
                                      }
                                      if (isAdmin == true) {
                                        type = "1";
                                      } else {
                                        type = "0";
                                      }
                                      updateEmployee(
                                          data,
                                          employeeNameContorlar.text,
                                          departmentitem!.id,
                                          rankitem!.id,
                                          jobitem!.id,
                                          type,
                                          contracted,
                                          data.password,
                                          employeeMembership,
                                          context);
                                    },

                                    child: Text(
                                      "edit".tr,
                                      style: TextStyle(
                                          color: AppColor.white,
                                          fontWeight: FontWeight.bold),
                                    ), //Icon(Icons.menu, color: Colors.white),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              18.0)), //CircleBorder(),
                                      padding: EdgeInsets.all(10),
                                      primary: AppColor.orange,
                                      onPrimary: Colors.blue,
                                    ),
                                  ),
                                )))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
