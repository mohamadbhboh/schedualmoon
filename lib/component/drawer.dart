import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedualmoon/component/app_color.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/component/drawer_listile.dart';
import 'package:schedualmoon/component/size_config.dart';
import 'package:schedualmoon/controllers/drawer_controller.dart';

class DrawerSection extends StatefulWidget {
  @override
  _DrawerState createState() => _DrawerState();
}

class _DrawerState extends State<DrawerSection> {
  final drawerController = Get.put(DrawerListController());
  @override
  Widget build(BuildContext context) {
    double _height = SizeConfig().getScreenHeight(context);
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: AppColor.blue),
      child: Drawer(
        //backgroundColor: AppColor.blue,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: AppColor.blue),
              child: Container(
                height: _height * 0.25,
                margin: EdgeInsets.only(
                    top: _height * 0.03, bottom: _height * 0.05),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  //border: Border.all(color: AppColor.blue, width: 3),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(5)),
                ),
                child: Column(
                  children: [
                    Image(
                      height: _height * 0.18,
                      image: AssetImage('images/logo.gif'),
                    ),
                    Center(
                      child: Text(
                        'appName'.tr,
                        style: TextStyle(
                            color: AppColor.orange,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  DrawerListTile(
                    icon: Icons.home,
                    press: () {
                      Get.offAllNamed('/home');
                      drawerController.selectedChange(0);
                      drawerController.closeDrawer();
                    },
                    title: 'homePage'.tr,
                    index: 0,
                  ),
                  DrawerListTile(
                    icon: Icons.people,
                    press: () {
                      drawerController.selectedChange(1);
                      drawerController.closeDrawer();
                      Get.toNamed('/employees');
                    },
                    title: 'employees'.tr,
                    index: 1,
                  ),
                  DrawerListTile(
                    icon: Icons.menu_book_outlined,
                    press: () {
                      drawerController.selectedChange(2);
                      drawerController.closeDrawer();
                      Get.toNamed('/courses');
                    },
                    title: 'courses'.tr,
                    index: 2,
                  ),
                  // DrawerListTile(
                  //   icon: Icons.person_pin_rounded,
                  //   press: () {
                  //     drawerController.selectedChange(3);
                  //   },
                  //   title: 'students'.tr,
                  //   index: 3,
                  // ),
                  DrawerListTile(
                      icon: Icons.school_rounded,
                      index: 4,
                      press: () {
                        drawerController.selectedChange(4);
                        drawerController.closeDrawer();
                        Get.toNamed('/collegs');
                        //drawerController.pageSelection.value = "colleges";
                      },
                      title: 'college'.tr),
                  DrawerListTile(
                      icon: Icons.splitscreen,
                      index: 13,
                      press: () {
                        drawerController.selectedChange(13);
                        drawerController.closeDrawer();
                        Get.toNamed('/departments');
                      },
                      title: 'departments'.tr),
                  DrawerListTile(
                      icon: Icons.engineering_rounded,
                      index: 5,
                      press: () {
                        drawerController.selectedChange(5);
                        drawerController.closeDrawer();
                        Get.toNamed('/permessions');
                      },
                      title: 'permission'.tr),
                  //this replace and remove into semester in main page
                  // DrawerListTile(
                  //     icon: Icons.question_answer_rounded,
                  //     index: 6,
                  //     press: () {
                  //       drawerController.selectedChange(6);
                  //       print('screenSize.height');
                  //     },
                  //     title: 'questionnarize'.tr),
                  // DrawerListTile(
                  //     icon: Icons.calendar_today_outlined,
                  //     index: 7,
                  //     press: () {
                  //       drawerController.selectedChange(7);
                  //       print('screenSize.height');
                  //     },
                  //     title: 'semester'.tr),
                  DrawerListTile(
                      icon: Icons.access_time_rounded,
                      index: 8,
                      press: () {
                        drawerController.selectedChange(8);
                        drawerController.closeDrawer();
                        Get.toNamed('/times');
                      },
                      title: 'time'.tr),
                  DrawerListTile(
                      icon: Icons.manage_accounts_outlined,
                      index: 9,
                      press: () {
                        drawerController.selectedChange(9);
                        drawerController.closeDrawer();
                        Get.toNamed('/jobs');
                      },
                      title: 'job'.tr),
                  DrawerListTile(
                      icon: Icons.library_books_outlined,
                      index: 10,
                      press: () {
                        drawerController.selectedChange(10);
                        drawerController.closeDrawer();
                        Get.toNamed('/ranks');
                      },
                      title: 'rank'.tr),
                  DrawerListTile(
                      icon: Icons.book,
                      index: 14,
                      press: () {
                        drawerController.selectedChange(14);
                        drawerController.closeDrawer();
                        Get.toNamed('/teachingMatrix');
                      },
                      title: 'teachingMatrix'.tr),
                  DrawerListTile(
                      icon: Icons.settings,
                      index: 11,
                      press: () {
                        drawerController.selectedChange(11);
                        drawerController.closeDrawer();
                        Get.toNamed('/setting');
                      },
                      title: 'setting'.tr),
                  Divider(
                    thickness: 1,
                    color: AppColor.white,
                  ),
                  DrawerListTile(
                      icon: Icons.login_outlined,
                      index: 12,
                      press: () {
                        drawerController.selectedChange(12);
                        print('screenSize.height');
                        Get.offAllNamed('/login');
                      },
                      title: 'logout'.tr),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
