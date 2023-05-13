import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/component/app_color.dart';
import 'package:schedualmoon/component/confirm_dialog.dart';
import 'package:schedualmoon/component/drawer.dart';
import 'package:schedualmoon/component/translations.dart';
import 'package:schedualmoon/controllers/app_responsive.dart';
import 'package:schedualmoon/controllers/drawer_controller.dart';
import 'package:schedualmoon/controllers/employee_controller.dart';
import 'package:schedualmoon/models/employees.dart';

// ignore: must_be_immutable
class EmployeeView extends StatelessWidget {
  final drawerController = Get.put(DrawerListController());
  final employeeController = Get.put(EmployeesController());
  final languageController = Get.put(Translation());
  Rx<DataSource> _dataSource = DataSource().obs;

  bool _search = false;
  int _rowsPerPage = 30;
  @override
  Widget build(BuildContext context) {
    _dataSource = DataSource(context: context).obs;

    if (AppResponsive.isDesktop(context)) {
      drawerController.closeDrawer();
    }
    return Scaffold(
        body: Row(
      children: [
        if (AppResponsive.isDesktop(context)) Expanded(child: DrawerSection()),
        Expanded(
          flex: 4,
          child: Column(children: [
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
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                      margin: EdgeInsets.only(top: 10),
                      child: IconButton(
                        icon: new Icon(Icons.add_circle_rounded),
                        iconSize: 50,
                        color: AppColor.blue,
                        tooltip: 'add'.tr,
                        onPressed: () {
                          Get.toNamed('/addEmployee');
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
                                                var result = employeeController
                                                    .employeesBackup
                                                    .where((element) => element
                                                        .name
                                                        .contains(val))
                                                    .toList();
                                                employeeController
                                                    .allEmploees.value = result;
                                                _dataSource.value = DataSource(
                                                    context: context);
                                              },
                                              maxLength: 50,
                                              decoration: InputDecoration(
                                                  hintText: 'employeeName'.tr,
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
                                          bottomRight:
                                              Radius.circular(_search ? 0 : 32),
                                          bottomLeft: Radius.circular(30),
                                          topRight: Radius.circular(
                                              _search ? 0 : 32)),
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
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20, right: 35, left: 40, bottom: 20),
            ),
            Obx(() {
              if (employeeController.isLoading.value == true) {
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
                        scrollDirection: Axis.vertical,
                        controller: ScrollController(),
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
                                  'employeeId'.tr,
                                  style: TextStyle(
                                      color: AppColor.blue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'employeeName'.tr,
                                  style: TextStyle(
                                      color: AppColor.blue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'department'.tr,
                                  style: TextStyle(
                                      color: AppColor.blue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'contracted'.tr,
                                  style: TextStyle(
                                      color: AppColor.blue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'membership'.tr,
                                  style: TextStyle(
                                      color: AppColor.blue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'rankNameTable'.tr,
                                  style: TextStyle(
                                      color: AppColor.blue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'jobNameTable'.tr,
                                  style: TextStyle(
                                      color: AppColor.blue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'type'.tr,
                                  style: TextStyle(
                                      color: AppColor.blue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                            source: _dataSource.value),
                      ),
                    ),
                  ),
                );
              }
            })
          ]),
        )
      ],
    ));
  }

  deleteItem(String id, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => ConfirmDialog(
              title: "deleteTitle".tr,
              description: "deleteDescription".tr,
              positivePress: () async {
                // print('before :' +
                //     employeeController.allEmploees
                //         .where((p0) => p0.id == id)
                //         .toList()[0]
                //         .id);
                var result =
                    await employeeController.deleteEmployee(id, context);
                if (result == true) {
                  employeeController.allEmploees
                      .removeWhere((element) => element.id == id);
                  employeeController.employeesBackup
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
}

class DataSource extends DataTableSource {
  final employeeController = Get.put(EmployeesController());
  final context;

  DataSource({this.context});
  @override
  DataRow? getRow(int index) {
    Employees employeeItem = employeeController.allEmploees[index];
    return DataRow(
        color: MaterialStateProperty.resolveWith(
            (states) => _getDataRowColor(states)),
        onSelectChanged: (bl) => {},
        cells: [
          DataCell(IconButton(
              onPressed: () {
                Get.toNamed('/updateEmployee', arguments: employeeItem);
              },
              icon: Icon(
                Icons.edit,
                color: AppColor.greenEdit,
              ))),
          DataCell(IconButton(
              onPressed: () {
                EmployeeView _employeeview = EmployeeView();
                _employeeview.deleteItem(employeeItem.id, context);
              },
              icon: Icon(
                Icons.delete,
                color: AppColor.redLight,
              ))),
          DataCell(Text(
            employeeItem.id,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )),
          DataCell(Text(
            employeeItem.name.toString(),
            style: TextStyle(fontSize: 16),
          )),
          DataCell(Text(
            employeeItem.departmentName.toString(),
            style: TextStyle(fontSize: 16),
          )),
          DataCell(Text(
            employeeItem.contracted.toString(),
            style: TextStyle(fontSize: 16),
          )),
          DataCell(Text(
            employeeItem.employeeMembership.toString(),
            style: TextStyle(fontSize: 16),
          )),
          DataCell(Text(
            employeeItem.rankName.toString(),
            style: TextStyle(fontSize: 16),
          )),
          DataCell(Text(
            employeeItem.jobName,
            style: TextStyle(fontSize: 16),
          )),
          DataCell(Text(
            employeeItem.type,
            style: TextStyle(fontSize: 16),
          )),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => employeeController.allEmploees.length;

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
