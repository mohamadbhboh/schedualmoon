import 'package:flutter/material.dart';
import 'package:schedualmoon/component/drawer.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/controllers/drawer_controller.dart';

class MyScaffold extends StatelessWidget {
  final drawerController = Get.put(DrawerListController());
  final Widget body;

  MyScaffold({required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      key: drawerController.scaffoldKey,
      drawer: DrawerSection(),
    );
  }
}
