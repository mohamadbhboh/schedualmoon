import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/component/app_color.dart';
import 'package:schedualmoon/component/drawer.dart';
import 'package:schedualmoon/component/translations.dart';
import 'package:schedualmoon/controllers/app_responsive.dart';
import 'package:schedualmoon/controllers/drawer_controller.dart';

class SettingView extends StatelessWidget {
  final translation = Get.put(Translation());
  final drawerController = Get.put(DrawerListController());

  @override
  Widget build(BuildContext context) {
    List<String> allLanguage = <String>["ar".tr, "en".tr];
    String _language = "ar".tr;

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
              Row(
                children: [
                  Expanded(
                    flex: 0,
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: ElevatedButton(
                          onPressed: () {
                            if (_language == "ar".tr)
                              translation.changeLanguage("ar");
                            else
                              translation.changeLanguage("en");
                          },
                          child: Text('apply'.tr)),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 25, right: 25),
                      child: StatefulBuilder(
                        builder: (BuildContext context, setState) {
                          return DropdownButtonFormField(
                            decoration: InputDecoration(
                                labelText: "selectLang".tr,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: AppColor.orange, width: 2)),
                                labelStyle: TextStyle(
                                    color: AppColor.black, fontSize: 20)),
                            value: _language,
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            onChanged: (String? newValue) {
                              setState(() {
                                _language = newValue!;
                              });
                            },
                            items: allLanguage
                                .map<DropdownMenuItem<String>>((String value) {
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
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    ));
  }
}
