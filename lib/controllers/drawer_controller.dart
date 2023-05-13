import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerListController extends GetxController {
  var selectedListTile = List<bool>.generate(15, (index) => false).obs;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  //var pageSelection = "home".obs;

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  @override
  void onInit() {
    selectedListTile[0] = true;
    super.onInit();
  }

  void selectedChange(int index) {
    for (int i = 0; i < selectedListTile.length; i++) {
      selectedListTile[i] = false;
    }
    selectedListTile[index] = true;
  }
}
