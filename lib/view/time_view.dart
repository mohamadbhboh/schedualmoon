import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/component/app_color.dart';
import 'package:schedualmoon/component/confirm_dialog.dart';
import 'package:schedualmoon/component/drawer.dart';
import 'package:schedualmoon/component/general_dialog.dart';
import 'package:schedualmoon/component/translations.dart';
import 'package:schedualmoon/controllers/app_responsive.dart';
import 'package:schedualmoon/controllers/drawer_controller.dart';
import 'package:schedualmoon/controllers/time_controller.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:count_by_clock/count_by_clock.dart';
import 'package:schedualmoon/models/time.dart';

class TimeView extends StatelessWidget {
  final drawerController = Get.put(DrawerListController());
  final timeController = Get.put(TimeController());
  final translation = Get.put(Translation());
  final timeClassController = new TextEditingController();
  final timeFromController = new TextEditingController();
  final timeToController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          if (AppResponsive.isDesktop(context))
            Expanded(child: DrawerSection()),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                //this section for icon drawer
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
                Obx(() {
                  if (timeController.isLoading.value == true) {
                    return Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return Expanded(
                        child: ListView(
                      controller: ScrollController(),
                      children: [
                        //add new time
                        Align(
                          alignment: translation.selectedLanguage.value == "ar"
                              ? Alignment.topRight
                              : Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: AppColor.bluelight,
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
                                          child: dialogContextAddTime(context),
                                        ));
                              },
                              child: Wrap(
                                children: <Widget>[
                                  Icon(
                                    Icons.alarm_add,
                                    color: AppColor.white,
                                    size: 24.0,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("addNewTime".tr,
                                      style: TextStyle(fontSize: 20)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        //end add new time
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            'timeSpecificDesc'.tr,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: IconButton(
                                  onPressed: () {
                                    int _counter =
                                        timeController.timeCounter.value + 1;
                                    if (timeController.allHours
                                        .contains(_counter)) {
                                      timeController.timeCounter.value =
                                          _counter;
                                      timeController.assignBasicTime(_counter);
                                    }
                                  },
                                  icon: Icon(Icons.plus_one_sharp)),
                            ),
                            Column(
                              children: [
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: CountByClock(
                                    timeController.timeCounter.value,
                                    tickColor: AppColor.blue,
                                    baseColor: AppColor.orange,
                                    clockArea: 40,
                                  ),
                                ),
                                Text(
                                  "${timeController.timeCounter.value} " +
                                      "clock".tr,
                                  style: TextStyle(
                                      color: AppColor.blue,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Expanded(
                              child: IconButton(
                                  onPressed: () {
                                    int _counter =
                                        timeController.timeCounter.value - 1;
                                    if (timeController.allHours
                                        .contains(_counter)) {
                                      timeController.timeCounter.value =
                                          _counter;
                                      timeController.assignBasicTime(_counter);
                                    }
                                  },
                                  icon: Icon(Icons.exposure_minus_1_outlined)),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        //here must view table and text
                        Center(
                          child: SingleChildScrollView(
                            controller: ScrollController(),
                            scrollDirection: Axis.vertical,
                            child: SingleChildScrollView(
                                controller: ScrollController(),
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                    headingRowColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => AppColor.bluelight),
                                    dataRowColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => AppColor.grayLight),
                                    headingTextStyle: TextStyle(
                                        color: AppColor.white, fontSize: 20),
                                    dataTextStyle: TextStyle(
                                        color: AppColor.black, fontSize: 16),
                                    columns: [
                                      DataColumn(
                                          label: Text('timeFrom'.tr),
                                          numeric: true),
                                      DataColumn(
                                        label: Text('timeTo'.tr),
                                        numeric: true,
                                      ),
                                      DataColumn(label: Text('delete'.tr)),
                                      DataColumn(label: Text('update'.tr))
                                    ],
                                    rows: timeController.allBasicTime
                                        .map(
                                            (basicTimeElement) => DataRow(
                                                    cells: [
                                                      DataCell(
                                                        Text(basicTimeElement
                                                            .time
                                                            .split('-')[0]),
                                                      ),
                                                      DataCell(Text(
                                                          basicTimeElement.time
                                                              .split('-')[1])),
                                                      DataCell(IconButton(
                                                          onPressed: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        ConfirmDialog(
                                                                          title:
                                                                              "deleteTitle".tr,
                                                                          description:
                                                                              "deleteDescription".tr,
                                                                          positivePress:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                            timeController.deleteTimes(basicTimeElement.id);
                                                                          },
                                                                          cancelPrsee:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          icon:
                                                                              Icons.delete,
                                                                          iconColor:
                                                                              AppColor.redDelete,
                                                                        ));
                                                          },
                                                          icon: Icon(
                                                            Icons.delete,
                                                            color: AppColor
                                                                .redLight,
                                                          ))),
                                                      DataCell(IconButton(
                                                          onPressed: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder: (context) => Dialog(
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                16)),
                                                                    elevation:
                                                                        0,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    child: dialogContextUpdateTime(
                                                                        context,
                                                                        timeController
                                                                            .timeCounter
                                                                            .value,
                                                                        basicTimeElement)));
                                                          },
                                                          icon: Icon(
                                                            Icons.edit,
                                                            color:
                                                                AppColor.green,
                                                          )))
                                                    ]))
                                        .toList())),
                          ),
                        ),
                        //end view table and text
                      ],
                    ));
                  }
                })
              ],
            ),
          )
        ],
      ),
    );
  }

  dialogContextAddTime(BuildContext context) {
    String timeClassValue = "1";
    String timeFromValue = "8";
    String timeToValue = "9";
    List<String> timeClassItems = <String>[
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8'
    ];
    List<String> timeFromItems = <String>[
      '8',
      '9',
      '10',
      '11',
      '12',
      '13',
      '14',
      '15'
    ];
    List<String> timeToItems = <String>[
      '9',
      '10',
      '11',
      '12',
      '13',
      '14',
      '15',
      '16'
    ];
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
                "addNewTime".tr,
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
                                  labelText: "timeSpecificDesc".tr,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: AppColor.orange, width: 2)),
                                  labelStyle: TextStyle(
                                      color: AppColor.black, fontSize: 20)),
                              value: timeClassValue,
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              onChanged: (String? newValue) {
                                setState(() {
                                  timeClassValue = newValue!;
                                });
                              },
                              items: timeClassItems
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
                              }).toList(),
                            ),
                            //drop down time from
                            SizedBox(
                              height: 25,
                            ),
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                  labelText: "timeFrom".tr,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: AppColor.orange, width: 2)),
                                  labelStyle: TextStyle(
                                      color: AppColor.black, fontSize: 20)),
                              value: timeFromValue,
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              onChanged: (String? newValue) {
                                setState(() {
                                  timeFromValue = newValue!;
                                });
                              },
                              items: timeFromItems
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
                              }).toList(),
                            ),
                            //end dropdown time from
                            SizedBox(
                              height: 25,
                            ),
                            //dropdown time to
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                  labelText: "timeTo".tr,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: AppColor.orange, width: 2)),
                                  labelStyle: TextStyle(
                                      color: AppColor.black, fontSize: 20)),
                              value: timeToValue,
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              onChanged: (String? newValue) {
                                setState(() {
                                  timeToValue = newValue!;
                                });
                              },
                              items: timeToItems.map<DropdownMenuItem<String>>(
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
                              }).toList(),
                            ),
                            //end dropdown timeto
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
                          int _to = int.parse(timeToValue);
                          int _from = int.parse(timeFromValue);
                          int _class = int.parse(timeClassValue);
                          if (_to - _from != _class) {
                            showDialog(
                                context: context,
                                builder: (context) => GeneralDialog(
                                    title: 'errorTime'.tr,
                                    description: 'errorTimeSelection'.tr,
                                    positivePress: () {
                                      Navigator.pop(context);
                                    },
                                    image: 'images/wrong.gif'));
                          } else {
                            String _time =
                                _from.toString() + '-' + _to.toString();
                            timeController.addTimes(_class.toString(), _time);
                          }
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
              Icons.alarm_add,
              size: 45,
              color: AppColor.white,
            ),
          ),
        )
      ],
    );
  }

  //this dialog to update time
  dialogContextUpdateTime(BuildContext context, int _class, AllBasicTime item) {
    String timeFromValue = item.time.split('-')[0];
    String timeToValue = item.time.split('-')[1];
    List<String> timeFromItems = <String>[
      '8',
      '9',
      '10',
      '11',
      '12',
      '13',
      '14',
      '15'
    ];
    List<String> timeToItems = <String>[
      '9',
      '10',
      '11',
      '12',
      '13',
      '14',
      '15',
      '16'
    ];
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
                "timeUpdate".tr,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 200,
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
                                  labelText: "timeFrom".tr,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: AppColor.orange, width: 2)),
                                  labelStyle: TextStyle(
                                      color: AppColor.black, fontSize: 20)),
                              value: timeFromValue,
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              onChanged: (String? newValue) {
                                setState(() {
                                  timeFromValue = newValue!;
                                });
                              },
                              items: timeFromItems
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
                              }).toList(),
                            ),
                            //end dropdown time from
                            SizedBox(
                              height: 25,
                            ),
                            //dropdown time to
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                  labelText: "timeTo".tr,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: AppColor.orange, width: 2)),
                                  labelStyle: TextStyle(
                                      color: AppColor.black, fontSize: 20)),
                              value: timeToValue,
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              onChanged: (String? newValue) {
                                setState(() {
                                  timeToValue = newValue!;
                                });
                              },
                              items: timeToItems.map<DropdownMenuItem<String>>(
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
                              }).toList(),
                            ),
                            //end dropdown timeto
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
                          int _to = int.parse(timeToValue);
                          int _from = int.parse(timeFromValue);
                          if (_to - _from != _class) {
                            EasyLoading.showError('errorSelection'.tr);
                          } else {
                            String time =
                                _from.toString() + '-' + _to.toString();
                            timeController.updateTime(time, item);
                          }
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
              Icons.alarm_add,
              size: 45,
              color: AppColor.white,
            ),
          ),
        )
      ],
    );
  }
}
