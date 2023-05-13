import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/component/app_color.dart';
import 'package:schedualmoon/component/confirm_dialog.dart';
import 'package:schedualmoon/component/drawer.dart';
import 'package:schedualmoon/component/size_config.dart';
import 'package:schedualmoon/controllers/app_responsive.dart';
import 'package:schedualmoon/controllers/drawer_controller.dart';
import 'package:schedualmoon/controllers/rank_controller.dart';
import 'package:schedualmoon/models/ranks.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:slimy_card/slimy_card.dart';
import 'package:schedualmoon/component/text_box.dart';

class RankView extends StatelessWidget {
  final drawerController = Get.put(DrawerListController());
  final rankController = Get.put(RankController());
  final GlobalKey<FormState> formValidEdit = new GlobalKey<FormState>();
  final GlobalKey<FormState> formValid = new GlobalKey<FormState>();
  final rankNameController = new TextEditingController();
  final rankHourController = new TextEditingController();
  final rankNameAdd = new TextEditingController();
  final rankHourAdd = new TextEditingController();
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

                //this section for add ranks
                StatefulBuilder(
                  builder: (BuildContext context, setState) {
                    return AnimatedContainer(
                      duration: Duration(seconds: 1),
                      decoration: rankController.addingItems.value == true
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColor.white,
                              boxShadow: kElevationToShadow[6],
                            )
                          : null,
                      width: rankController.addingItems.value ? 400 : 150,
                      height: rankController.addingItems.value ? 250 : 38,
                      child: ListView(
                        controller: ScrollController(),
                        children: [
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
                                      if (rankController.addingItems.value ==
                                          false) {
                                        setState(() {
                                          rankController.addingItems.value =
                                              true;
                                        });
                                      }
                                      //click to add elements
                                      else {
                                        if (formValid.currentState!.validate())
                                          rankController.addRank(context,
                                              rankNameAdd, rankHourAdd);
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
                                        Text("add".tr,
                                            style: TextStyle(fontSize: 20)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                  visible: rankController.addingItems.value,
                                  child: Expanded(
                                      child: Align(
                                    alignment: Alignment.topLeft,
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            rankController.addingItems.value =
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
                            visible: rankController.addingItems.value,
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
                                      controllarName: rankNameAdd,
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
                                      controllarName: rankHourAdd,
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
                SizedBox(
                  height: 20,
                ),

                //this section for view ranks
                Obx(() {
                  if (rankController.isLoading.value == true)
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
                        itemCount: rankController.allRanks.length,
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
                                  'rankName'.tr +
                                      rankController.allRanks[index].name,
                                  style: TextStyle(
                                      color: AppColor.white, fontSize: 20),
                                )),
                                Center(
                                  child: Text(
                                    'rankHour'.tr +
                                        rankController
                                            .allRanks[index].hourNumber,
                                    style: TextStyle(
                                        color: AppColor.white, fontSize: 20),
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
                                          builder: (context) => ConfirmDialog(
                                                title: "deleteTitle".tr,
                                                description:
                                                    "deleteDescription".tr,
                                                positivePress: () {
                                                  Navigator.pop(context);
                                                  rankController.deleteRank(
                                                      rankController
                                                          .allRanks[index].id,
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
                                                    rankController
                                                        .allRanks[index]),
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
                        },
                      ),
                    );
                  }
                }),
                //end add ranks section

                //get data from repository
              ],
            ),
          )
        ],
      ),
    );
  }

  dialogContext(BuildContext context, Ranks item) {
    rankNameController.text = item.name;
    rankHourController.text = item.hourNumber;
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
                          name: 'rankNameInput'.tr,
                          controllarName: rankNameController,
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
                            controllarName: rankHourController,
                            myicon: Icons.filter_2,
                            inputvalid: (value) {
                              if (value == "") {
                                return 'emptyString'.tr;
                              }
                            },
                            isNumber: true),
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
                            rankController.updateRank(
                                item,
                                rankNameController.text,
                                rankHourController.text,
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
