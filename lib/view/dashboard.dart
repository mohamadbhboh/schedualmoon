import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/component/app_color.dart';
import 'package:schedualmoon/component/size_config.dart';
import 'package:schedualmoon/component/translations.dart';
import 'package:schedualmoon/controllers/app_responsive.dart';
import 'package:schedualmoon/controllers/drawer_controller.dart';

class DashBoard extends StatelessWidget {
  final translation = Get.put(Translation());
  final drawerController = Get.put(DrawerListController());
  final departmentId;

  DashBoard({required this.departmentId});
  @override
  Widget build(BuildContext context) {
    double _width = SizeConfig().getScreenWidth(context);
    double _height = SizeConfig().getScreenHeight(context);
    if (AppResponsive.isDesktop(context)) {
      drawerController.closeDrawer();
    }
    return Scaffold(
        body: Column(
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
        Expanded(
            child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColor.black,
                    AppColor.lighteblue,
                    AppColor.syan,
                  ],
                  stops: [
                    0.2,
                    0.6,
                    1,
                  ],
                ),
              ),
            ),
            Positioned(
              child: Column(
                children: [
                  Center(
                    child: Image(
                      image: AssetImage('images/schedual_text.png'),
                      width: AppResponsive.isTablet(context)
                          ? _width * 0.4
                          : _width * 0.2,
                    ),
                  ),
                ],
              ),
            ),
            //above
            Center(
              child: Container(
                width: AppResponsive.isDesktop(context)
                    ? _width * 0.6
                    : AppResponsive.isTablet(context)
                        ? _width * 0.8
                        : _width,
                height: AppResponsive.isDesktop(context)
                    ? _height * 0.6
                    : AppResponsive.isTablet(context)
                        ? _height * 0.4
                        : _height * 0.4,
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/ai_home.gif'),
                            fit: BoxFit.cover),
                      ),
                    )),
                    Expanded(
                        child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(25),
                            gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColor.lighteblue,
                                AppColor.black,
                                AppColor.lighteblue,
                                AppColor.black,
                              ],
                              stops: [
                                0.2,
                                1.5,
                                0.8,
                                1,
                              ],
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 40),
                                child: Center(
                                  child: Text(
                                    'schedualDesc'.tr,
                                    style: TextStyle(
                                        color: AppColor.orange,
                                        fontSize:
                                            AppResponsive.isDesktop(context)
                                                ? 30
                                                : 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Container(
                                  child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: AppColor.lighteOrange,
                                ),
                                onPressed: () {
                                  Get.toNamed('/semester',
                                      arguments: [departmentId]);
                                },
                                child: Wrap(
                                  children: <Widget>[
                                    Icon(
                                      Icons.arrow_back,
                                      color: AppColor.bluelight,
                                      size: 24.0,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text("semesterMoving".tr,
                                        style: TextStyle(fontSize: 20)),
                                  ],
                                ),
                              )),
                            ],
                          ),
                        )
                      ],
                    ))
                  ],
                ),
              ),
            )
          ],
        ))
      ],
    ));
  }
}
