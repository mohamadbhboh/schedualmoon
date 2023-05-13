import 'package:flutter/material.dart';
import 'package:schedualmoon/component/app_color.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/component/size_config.dart';
import 'package:schedualmoon/controllers/employee_controller.dart';
import 'package:schedualmoon/models/jobRankDepartmentmodel.dart';

class AddEmployee extends StatelessWidget {
  final GlobalKey<FormState> formValidAdd = new GlobalKey<FormState>();
  final addEmployeeController = Get.put(EmployeesController());

  @override
  Widget build(BuildContext context) {
    double _height = SizeConfig().getScreenHeight(context);
    final employeeNameContorlar = new TextEditingController();
    final employeePasswordContorlar = new TextEditingController();
    List<String> allJobs = [];
    List<String> allRanks = [];
    List<String> allDepartment = [];
    bool iscontracted = false;
    bool ismemberShipteaching = false;
    bool isAdmin = false;

    addEmployeeController.allJobRankDepartments.jobs.forEach((element) {
      allJobs.add(element.name);
    });
    addEmployeeController.allJobRankDepartments.ranks.forEach((element) {
      allRanks.add(element.name);
    });
    addEmployeeController.allJobRankDepartments.department.forEach((element) {
      allDepartment.add(element.name);
    });
    String departmentName = allDepartment[0];
    String jobName = allJobs[0];
    String rankName = allRanks[0];
    createEmployee(
      BuildContext context,
      String name,
      String departmentId,
      String rankId,
      String jobId,
      String type,
      String contracted,
      String password,
      String employeeMembership,
    ) {
      if (formValidAdd.currentState!.validate()) {
        addEmployeeController.addEmployee(context, name, password, departmentId,
            jobId, rankId, type, contracted, employeeMembership);
      }
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
            'addEmployee'.tr,
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
                    key: formValidAdd,
                    child: Column(children: [
                      TextFormField(
                        style: TextStyle(
                            color: AppColor.blue, fontWeight: FontWeight.bold),
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
                      TextFormField(
                        style: TextStyle(
                            color: AppColor.blue, fontWeight: FontWeight.bold),
                        maxLength: 50,
                        controller: employeePasswordContorlar,
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if (value == "") {
                            return 'Text Is Empty';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "password".tr,
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
                              value: departmentName,
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              onChanged: (newValue) {
                                setState(() {
                                  departmentName = newValue!.toString();
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
                              value: jobName,
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              onChanged: (newValue) {
                                setState(() {
                                  jobName = newValue!.toString();
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
                              value: rankName,
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              onChanged: (newValue) {
                                setState(() {
                                  rankName = newValue!.toString();
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
                                iscontracted = newValue!;
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
                            value: ismemberShipteaching,
                            onChanged: (newValue) {
                              setState(() {
                                ismemberShipteaching = newValue as bool;
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
                                isAdmin = newValue!;
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

                                    addEmployeeController
                                        .allJobRankDepartments.ranks
                                        .forEach((element) {
                                      if (element.name == rankName) {
                                        rankitem = element;
                                      }
                                    }) as Rank;
                                    addEmployeeController
                                        .allJobRankDepartments.jobs
                                        .forEach((element) {
                                      if (element.name == jobName) {
                                        jobitem = element;
                                      }
                                    }) as Job;

                                    addEmployeeController
                                        .allJobRankDepartments.department
                                        .forEach((element) {
                                      if (element.name == departmentName) {
                                        departmentitem = element;
                                      }
                                    }) as Department;

                                    if (ismemberShipteaching == true) {
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
                                    createEmployee(
                                        context,
                                        employeeNameContorlar.text,
                                        departmentitem!.id,
                                        rankitem!.id,
                                        jobitem!.id,
                                        type,
                                        contracted,
                                        employeePasswordContorlar.text,
                                        employeeMembership);
                                  },

                                  child: Text(
                                    "add".tr,
                                    style: TextStyle(
                                        color: AppColor.white,
                                        fontWeight: FontWeight.bold),
                                  ), //Icon(Icons.menu, color: Colors.white),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0)),
                                    padding: EdgeInsets.all(10),
                                    primary: AppColor.orange,
                                    onPrimary: Colors.blue,
                                  ),
                                ),
                              )))
                    ]),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
