import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/component/app_color.dart';
import 'package:schedualmoon/component/confirm_dialog.dart';
import 'package:schedualmoon/component/drawer.dart';
import 'package:schedualmoon/component/size_config.dart';
import 'package:schedualmoon/controllers/app_responsive.dart';
import 'package:schedualmoon/controllers/drawer_controller.dart';
import 'package:schedualmoon/controllers/job_controller.dart';
import 'package:schedualmoon/models/jobs.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:slimy_card/slimy_card.dart';
import 'package:schedualmoon/component/text_box.dart';

class JobView extends StatelessWidget {
  final drawerController = Get.put(DrawerListController());
  final jobController = Get.put(JobsController());
  final GlobalKey<FormState> formValidEdit = new GlobalKey<FormState>();
  final GlobalKey<FormState> formValid = new GlobalKey<FormState>();
  final jobNameController = new TextEditingController();
  final jobHourController = new TextEditingController();
  final jobNameAdd = new TextEditingController();
  final jobHourAdd = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    double _width = SizeConfig().getScreenWidth(context);
    return Scaffold(
      body: Row(
        children: [
          if (AppResponsive.isDesktop(context))
            Expanded(child: DrawerSection()),
          Expanded(
              flex: 4,
              child: Column(
                children: [
                  //this section for drawer menu
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

                  //end drawer menu
                  //this section for add jobs
                  StatefulBuilder(
                    builder: (BuildContext context, setState) {
                      return AnimatedContainer(
                        duration: Duration(seconds: 1),
                        decoration: jobController.addingItems.value == true
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColor.grayLight,
                                boxShadow: kElevationToShadow[6],
                              )
                            : null,
                        width: jobController.addingItems.value ? 400 : 150,
                        height: jobController.addingItems.value ? 250 : 38,
                        child: ListView(
                          controller: ScrollController(),
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 0,
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: AppColor.bluelight,
                                      ),
                                      onPressed: () {
                                        if (jobController.addingItems.value ==
                                            false) {
                                          setState(() {
                                            jobController.addingItems.value =
                                                true;
                                          });
                                        }
                                        //click to add elements
                                        else {
                                          if (formValid.currentState!
                                              .validate())
                                            jobController.addJob(context,
                                                jobNameAdd, jobHourAdd);
                                        }
                                      },
                                      child: Wrap(
                                        children: <Widget>[
                                          Icon(
                                            Icons.person_add_rounded,
                                            color: AppColor.orange,
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
                                Visibility(
                                    visible: jobController.addingItems.value,
                                    child: Expanded(
                                        child: Align(
                                      alignment: Alignment.topLeft,
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              jobController.addingItems.value =
                                                  false;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.close,
                                            color: AppColor.bluelight,
                                          )),
                                    )))
                              ],
                            ),
                            Visibility(
                              visible: jobController.addingItems.value,
                              child: Form(
                                  key: formValid,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      TextBox(
                                        isPassword: false,
                                        mxaLength: 25,
                                        name: 'rankNameInput'.tr,
                                        controllarName: jobNameAdd,
                                        myicon: Icons.library_books_outlined,
                                        inputvalid: (value) {
                                          if (value == "") {
                                            return 'emptyString'.tr;
                                          }
                                        },
                                        isNumber: false,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextBox(
                                        isPassword: false,
                                        mxaLength: 2,
                                        name: 'rankHourInput'.tr,
                                        controllarName: jobHourAdd,
                                        myicon: Icons.filter_2,
                                        inputvalid: (value) {
                                          if (value == "") {
                                            return 'emptyString'.tr;
                                          }
                                        },
                                        isNumber: true,
                                      ),
                                    ],
                                  )),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  //end add ranks
                  //end add jobs
                  SizedBox(
                    height: 20,
                  ),
                  //this section for view ranks
                  Obx(() {
                    if (jobController.isLoading.value == true)
                      return Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    else {
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
                            itemCount: jobController.allJobs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SlimyCard(
                                width: AppResponsive.isDesktop(context)
                                    ? _width * 0.25
                                    : AppResponsive.isTablet(context)
                                        ? _width * 0.40
                                        : _width * 0.80,
                                //note : in slimy card this size  at least
                                topCardHeight: AppResponsive.isDesktop(context)
                                    ? 170
                                    : 200,
                                bottomCardHeight: 100,
                                color: AppColor.orange,
                                topCardWidget: Column(
                                  children: [
                                    Center(
                                        child: Text(
                                      'jobName'.tr +
                                          jobController.allJobs[index].name,
                                      style: TextStyle(
                                          color: AppColor.white, fontSize: 20),
                                    )),
                                    Center(
                                      child: Text(
                                        'jobHour'.tr +
                                            jobController
                                                .allJobs[index].hourDiscount,
                                        style: TextStyle(
                                            color: AppColor.white,
                                            fontSize: 20),
                                      ),
                                    )
                                  ],
                                ),
                                bottomCardWidget: Row(
                                  children: [
                                    Expanded(
                                      child: ListTile(
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
                                                      jobController.deleteJobs(
                                                          jobController
                                                              .allJobs[index]
                                                              .id,
                                                          context);
                                                    },
                                                    cancelPrsee: () {
                                                      Navigator.pop(context);
                                                    },
                                                    icon: Icons.delete,
                                                    iconColor:
                                                        AppColor.redDelete,
                                                  ));
                                        },
                                        title: Text('delete'.tr,
                                            style: TextStyle(
                                                color: AppColor.white,
                                                fontSize: 20)),
                                        leading: Icon(
                                          Icons.delete_forever,
                                          color: AppColor.redLight,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: ListTile(
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
                                                    child: dialogContext(
                                                        context,
                                                        jobController
                                                            .allJobs[index]),
                                                  ));
                                        },
                                        title: Text('edit'.tr,
                                            style: TextStyle(
                                                color: AppColor.white,
                                                fontSize: 20)),
                                        leading: Icon(
                                          Icons.edit,
                                          color: AppColor.greenEdit,
                                          size: 30,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                      );
                    }
                  })
                  //end view ranks
                ],
              ))
        ],
      ),
    );
  }

  dialogContext(BuildContext context, Jobs item) {
    jobNameController.text = item.name;
    jobHourController.text = item.hourDiscount;
    return Stack(
      children: [
        Container(
          width: 400,
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
                "rankEdit".tr,
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
                child: Form(
                    key: formValidEdit,
                    child: Column(
                      children: [
                        TextBox(
                          isPassword: false,
                          mxaLength: 25,
                          name: 'jobNameInput'.tr,
                          controllarName: jobNameController,
                          myicon: Icons.library_books_outlined,
                          inputvalid: (value) {
                            if (value == "") {
                              return 'emptyString'.tr;
                            }
                          },
                          isNumber: false,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextBox(
                          isNumber: true,
                          isPassword: false,
                          mxaLength: 2,
                          name: 'jobHourInput'.tr,
                          controllarName: jobHourController,
                          myicon: Icons.filter_2,
                          inputvalid: (value) {
                            if (value == "") {
                              return 'emptyString'.tr;
                            }
                          },
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          if (formValidEdit.currentState!.validate())
                            jobController.updateJob(
                                item,
                                jobNameController.text,
                                jobHourController.text,
                                context);
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
}
