import 'package:flutter/material.dart';
import 'package:schedualmoon/component/app_color.dart';
import 'package:schedualmoon/component/drawer.dart';
import 'package:schedualmoon/controllers/app_responsive.dart';
import 'package:schedualmoon/controllers/drawer_controller.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/controllers/permession_controller.dart';

//because  search bool i put this
// ignore: must_be_immutable
class PermessionView extends StatelessWidget {
  final drawerController = Get.put(DrawerListController());
  final permessionController = Get.put(PermessionController());
  bool _search = false;
  @override
  Widget build(BuildContext context) {
    if (AppResponsive.isDesktop(context)) {
      drawerController.closeDrawer();
    }
    return Scaffold(
        body: Row(
      children: [
        if (AppResponsive.isDesktop(context)) Expanded(child: DrawerSection()),
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
                //this container  to add permession
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
                                              var result = permessionController
                                                  .allPermessionsBackup
                                                  .where((element) => element
                                                      .name
                                                      .contains(val))
                                                  .toList();
                                              permessionController
                                                  .allPermessions
                                                  .value = result;
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
                                        topRight:
                                            Radius.circular(_search ? 0 : 32)),
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
                SizedBox(
                  height: 20,
                ),
                //end add permession section
                //get data from repository
                Obx(() {
                  if (permessionController.isLoading.value == true)
                    return Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  else {
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
                              DataColumn(
                                onSort: (i, b) {
                                  permessionController.allPermessions
                                      .sort((a, b) => a.name.compareTo(b.name));
                                },
                                label: Text('employeeName'.tr),
                                numeric: false,
                              ),
                              DataColumn(
                                  label: Text('department'.tr),
                                  numeric: false,
                                  onSort: (i, b) {
                                    permessionController.allPermessions.sort((a,
                                            b) =>
                                        a.department.compareTo(b.department));
                                  }),
                              DataColumn(
                                label: Text('add'.tr),
                                numeric: false,
                              ),
                              DataColumn(
                                label: Text('read'.tr),
                                numeric: false,
                              ),
                              DataColumn(
                                label: Text('update'.tr),
                                numeric: false,
                              ),
                              DataColumn(
                                label: Text('delete'.tr),
                                numeric: false,
                              ),
                            ],
                            rows: permessionController.allPermessions
                                .map((permessionItem) => DataRow(cells: [
                                      DataCell(Text(permessionItem.name)),
                                      DataCell(Text(permessionItem.department)),
                                      DataCell(
                                        StatefulBuilder(
                                          builder:
                                              (BuildContext context, setState) {
                                            return Checkbox(
                                              value: permessionItem.create,
                                              onChanged: (val) async {
                                                if (val == true) {
                                                  var result =
                                                      await permessionController
                                                          .grantPermession(
                                                    permessionItem,
                                                    '1',
                                                  );
                                                  if (result == true) {
                                                    print('true');

                                                    setState(() {
                                                      permessionItem.create =
                                                          true;
                                                    });
                                                  }
                                                } else {
                                                  var result =
                                                      await permessionController
                                                          .revokePermession(
                                                    permessionItem,
                                                    '1',
                                                  );
                                                  if (result == true) {
                                                    print('true');
                                                    setState(() {
                                                      permessionItem.create =
                                                          false;
                                                    });
                                                  }
                                                }
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      DataCell(
                                        StatefulBuilder(
                                          builder:
                                              (BuildContext context, setState) {
                                            return Checkbox(
                                              value: permessionItem.read,
                                              onChanged: (val) async {
                                                if (val == true) {
                                                  var result =
                                                      await permessionController
                                                          .grantPermession(
                                                    permessionItem,
                                                    '4',
                                                  );
                                                  if (result == true) {
                                                    print('true');
                                                    setState(() {
                                                      permessionItem.read =
                                                          true;
                                                    });
                                                  }
                                                } else {
                                                  var result =
                                                      await permessionController
                                                          .revokePermession(
                                                    permessionItem,
                                                    '4',
                                                  );
                                                  if (result == true) {
                                                    print('true');
                                                    setState(() {
                                                      permessionItem.read =
                                                          false;
                                                    });
                                                  }
                                                }
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      DataCell(
                                        StatefulBuilder(
                                          builder:
                                              (BuildContext context, setState) {
                                            return Checkbox(
                                              value: permessionItem.update,
                                              onChanged: (val) async {
                                                if (val == true) {
                                                  var result =
                                                      await permessionController
                                                          .grantPermession(
                                                    permessionItem,
                                                    '3',
                                                  );
                                                  if (result == true) {
                                                    print('true');

                                                    setState(() {
                                                      permessionItem.update =
                                                          true;
                                                    });
                                                  }
                                                } else {
                                                  var result =
                                                      await permessionController
                                                          .revokePermession(
                                                    permessionItem,
                                                    '3',
                                                  );
                                                  if (result == true) {
                                                    print('true');
                                                    setState(() {
                                                      permessionItem.update =
                                                          false;
                                                    });
                                                  }
                                                }
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      DataCell(
                                        StatefulBuilder(
                                          builder:
                                              (BuildContext context, setState) {
                                            return Checkbox(
                                              value: permessionItem.delete,
                                              onChanged: (val) async {
                                                if (val == true) {
                                                  var result =
                                                      await permessionController
                                                          .grantPermession(
                                                    permessionItem,
                                                    '2',
                                                  );
                                                  if (result == true) {
                                                    print('true');

                                                    setState(() {
                                                      permessionItem.delete =
                                                          true;
                                                    });
                                                  }
                                                } else {
                                                  var result =
                                                      await permessionController
                                                          .revokePermession(
                                                    permessionItem,
                                                    '2',
                                                  );
                                                  if (result == true) {
                                                    print('true');
                                                    setState(() {
                                                      permessionItem.delete =
                                                          false;
                                                    });
                                                  }
                                                }
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ]))
                                .toList()),
                      ),
                    ));
                  }
                })
              ],
            ))
      ],
    ));
  }
}
