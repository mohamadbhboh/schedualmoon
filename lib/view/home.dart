import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/component/app_color.dart';
import 'package:schedualmoon/component/drawer.dart';
import 'package:schedualmoon/controllers/app_responsive.dart';
import 'package:schedualmoon/controllers/drawer_controller.dart';
import 'package:schedualmoon/view/dashboard.dart';
import 'package:universal_html/html.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  final drawerController = Get.put(DrawerListController());
  Storage _localStorage = window.localStorage;

  @override
  Widget build(BuildContext context) {
    String? departmentId = _localStorage['dept'];
    return Scaffold(
      backgroundColor: AppColor.blue,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //side navigation menu
            if (AppResponsive.isDesktop(context))
              Expanded(child: DrawerSection()),
            //main body part
            // if (drawerController.pageSelection.value == "home")
            Expanded(
                flex: 4,
                child: DashBoard(
                  departmentId: departmentId,
                ))
            // else if (drawerController.pageSelection.value == "colleges")
            //   Expanded(flex: 4, child: CollegesView())
          ],
        ),
      ),
    );
  }
}
