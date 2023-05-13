import 'package:flutter/material.dart';

class AppResponsive extends StatelessWidget {
  final Widget tablet;
  final Widget desktop;
  final Widget mobile;
  AppResponsive(
      {required this.tablet, required this.desktop, required this.mobile});
  static bool isMobile(context) => MediaQuery.of(context).size.width < 600;
  static bool isTablet(context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 600;
  static bool isDesktop(context) => MediaQuery.of(context).size.width >= 1100;
  @override
  Widget build(BuildContext context) {
    if (isDesktop(context)) {
      return desktop;
    } else if (isTablet(context)) {
      return tablet;
    } else {
      return mobile;
    }
  }
}
