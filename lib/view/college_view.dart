import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/component/app_color.dart';
import 'package:schedualmoon/component/drawer.dart';
import 'package:schedualmoon/component/confirm_dialog.dart';
import 'package:schedualmoon/component/size_config.dart';
import 'package:schedualmoon/component/text_box.dart';
import 'package:schedualmoon/controllers/app_responsive.dart';
import 'package:schedualmoon/controllers/college_controller.dart';
import 'package:schedualmoon/controllers/drawer_controller.dart';
import 'package:schedualmoon/models/colleges.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:slimy_card/slimy_card.dart';

class CollegesView extends StatelessWidget {
  final drawerController = Get.put(DrawerListController());
  final collegeController = Get.put(CollegesController());
  final collegeNameController = new TextEditingController();
  final collegeEditController = new TextEditingController();
  final GlobalKey<FormState> formValid = new GlobalKey<FormState>();
  final GlobalKey<FormState> formValidEdit = new GlobalKey<FormState>();

  addCollege(String name, BuildContext context) {
    if (formValid.currentState!.validate()) {
      collegeController.addColege(name, context, collegeNameController);
    }
  }

  @override
  Widget build(BuildContext context) {
    double _width = SizeConfig().getScreenWidth(context);
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
              Row(
                children: [
                  Expanded(
                      flex: 0,
                      child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: AppColor.lighteOrange,
                          ),
                          onPressed: () {
                            if (collegeController.addingItems.value == false) {
                              collegeController.addingItems.value = true;
                            }
                            //click to add elements
                            else {
                              addCollege(collegeNameController.text, context);
                            }
                          },
                          child: Wrap(
                            children: <Widget>[
                              Icon(
                                Icons.person_add_rounded,
                                color: AppColor.bluelight,
                                size: 24.0,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("add".tr, style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        ),
                      )),
                  Obx(() => Expanded(
                      flex: 0,
                      child: IconButton(
                          onPressed: () {
                            if (collegeController.addingItems.value == false) {
                              collegeController.addingItems.value = true;
                            } else {
                              collegeController.addingItems.value = false;
                            }
                          },
                          icon: Icon(
                            collegeController.addingItems.value == false
                                ? Icons.arrow_forward_ios_rounded
                                : Icons.arrow_back_ios,
                            color: AppColor.blue,
                          )))),
                  Obx(() => Expanded(
                      flex: 1,
                      child: Visibility(
                        visible: collegeController.addingItems.value,
                        child: Form(
                          key: formValid,
                          child: Container(
                            margin:
                                EdgeInsets.only(left: 10, right: 10, top: 18),
                            height: 70,
                            child: TextBox(
                              isPassword: false,
                              mxaLength: 35,
                              name: 'addCollege'.tr,
                              controllarName: collegeNameController,
                              myicon: Icons.person_add_rounded,
                              inputvalid: (value) {
                                if (value == "") {
                                  return 'النص فارغ';
                                }
                              },
                              isNumber: false,
                            ),
                          ),
                        ),
                      )))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              //this section for view data
              Obx(() {
                if (collegeController.isLoading.value == true)
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                else {
                  return Expanded(
                    child: GridView.builder(
                      controller: ScrollController(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: AppResponsive.isDesktop(context)
                            ? 3
                            : AppResponsive.isTablet(context)
                                ? 2
                                : 1,
                      ),
                      itemCount: collegeController.allColleges.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SlimyCard(
                            width: AppResponsive.isDesktop(context)
                                ? _width * 0.25
                                : AppResponsive.isTablet(context)
                                    ? _width * 0.40
                                    : _width * 0.80,
                            //note : in slimy card this size  at least
                            topCardHeight:
                                AppResponsive.isDesktop(context) ? 170 : 200,
                            bottomCardHeight: 100,
                            color: Colors.blueAccent,
                            topCardWidget: Column(
                              children: [
                                Center(
                                    child: Text(
                                  'collegeId'.tr +
                                      collegeController.allColleges[index].id,
                                  style: TextStyle(
                                      color: AppColor.white, fontSize: 20),
                                )),
                                Center(
                                  child: Text(
                                    'collegeName'.tr +
                                        collegeController
                                            .allColleges[index].name,
                                    style: TextStyle(
                                        color: AppColor.white, fontSize: 20),
                                  ),
                                )
                              ],
                            ),
                            //this section for below slimycard
                            bottomCardWidget: Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => ConfirmDialog(
                                                title: "deleteTitle".tr,
                                                description:
                                                    "deleteDescription".tr,
                                                positivePress: () {
                                                  Navigator.pop(context);
                                                  collegeController
                                                      .deleteCollege(
                                                          collegeController
                                                              .allColleges[
                                                                  index]
                                                              .id,
                                                          context);
                                                },
                                                cancelPrsee: () {
                                                  Navigator.pop(context);
                                                },
                                                icon: Icons.delete,
                                                iconColor: AppColor.redDelete,
                                              ));
                                    },
                                    title: Text('delete'.tr,
                                        style: TextStyle(
                                            color: AppColor.white,
                                            fontSize: 20)),
                                    leading: Icon(
                                      Icons.delete_forever,
                                      color: AppColor.redDelete,
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
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16)),
                                                elevation: 0,
                                                backgroundColor:
                                                    Colors.transparent,
                                                child: dialogContext(
                                                    context,
                                                    collegeController
                                                        .allColleges[index]),
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
                            ));
                      },
                    ),
                  );
                }
              })
            ],
          ),
        ),
      ],
    ));
  }

  updateElement(Colleges item, BuildContext context) {
    if (formValidEdit.currentState!.validate())
      collegeController.updateCollege(
          item, collegeEditController.text, context);
  }

  dialogContext(BuildContext context, Colleges item) {
    collegeEditController.text = item.name;
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
                "editCollege".tr,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 80,
                child: Form(
                  key: formValidEdit,
                  child: TextBox(
                    isPassword: false,
                    mxaLength: 35,
                    name: 'addCollege'.tr,
                    controllarName: collegeEditController,
                    myicon: Icons.person_add_rounded,
                    inputvalid: (value) {
                      if (value == "") {
                        return 'emptyString'.tr;
                      }
                    },
                    isNumber: false,
                  ),
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
                          updateElement(item, context);
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
              color: AppColor.blue,
            ),
          ),
        )
      ],
    );
  }
}
