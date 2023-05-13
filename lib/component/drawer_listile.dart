import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/component/app_color.dart';
import 'package:schedualmoon/component/translations.dart';
import 'package:schedualmoon/controllers/drawer_controller.dart';

class DrawerListTile extends StatelessWidget {
  final drawerController = Get.put(DrawerListController());
  final translation = Get.put(Translation());
  final icon;
  final index;
  final String title;
  final VoidCallback press;
  DrawerListTile(
      {required this.icon,
      required this.press,
      required this.title,
      @required this.index});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          color: drawerController.selectedListTile[index] == true
              ? AppColor.blue
              : null,
        ),
        child: Container(
          margin: translation.selectedLanguage.value == "en"
              ? EdgeInsets.only(left: 10)
              : EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: drawerController.selectedListTile[index]
                ? AppColor.white
                : null,
            borderRadius: translation.selectedLanguage.value == "en"
                ? BorderRadius.only(
                    topLeft: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
          ),
          child: ListTile(
            focusColor: AppColor.white,
            hoverColor: Color.fromRGBO(173, 175, 179, 0.7),
            selectedTileColor: AppColor.white,
            selected: drawerController.selectedListTile[index],
            onTap: press,
            horizontalTitleGap: 0.0,
            leading: Icon(icon,
                color: drawerController.selectedListTile[index]
                    ? AppColor.blue
                    : AppColor.orange),
            title: Text(
              title,
              style: TextStyle(
                  color: drawerController.selectedListTile[index]
                      ? AppColor.blue
                      : AppColor.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    });
  }
}
