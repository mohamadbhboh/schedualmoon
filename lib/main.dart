import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schedualmoon/component/app_color.dart';
import 'package:schedualmoon/component/drawer.dart';
import 'package:schedualmoon/component/translations.dart';
import 'package:schedualmoon/controllers/app_responsive.dart';
import 'package:schedualmoon/controllers/drawer_controller.dart';
import 'package:schedualmoon/view/add_employee_view.dart';
import 'package:schedualmoon/view/classes_view.dart';
import 'package:schedualmoon/view/college_view.dart';
import 'package:schedualmoon/view/course_add_view.dart';
import 'package:schedualmoon/view/course_update_view.dart';
import 'package:schedualmoon/view/course_view.dart';
import 'package:schedualmoon/view/department_view.dart';
import 'package:schedualmoon/view/employee_semester_view.dart';
import 'package:schedualmoon/view/employee_view.dart';
import 'package:schedualmoon/view/graduate_student_view.dart';
import 'package:schedualmoon/view/home.dart';
import 'package:schedualmoon/view/job_view.dart';
import 'package:schedualmoon/view/login_view.dart';
import 'package:schedualmoon/view/open_course.dart';
import 'package:schedualmoon/view/open_course_reqiurement.dart';
import 'package:schedualmoon/view/permession_view.dart';
import 'package:schedualmoon/view/program_view.dart';
import 'package:schedualmoon/view/rank_view.dart';
import 'package:schedualmoon/view/semester_view.dart';
import 'package:schedualmoon/view/setting.dart';
import 'package:schedualmoon/view/teaching_matrix_view.dart';
import 'package:schedualmoon/view/time_view.dart';
import 'package:schedualmoon/view/update_employee_view.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  configLoading();
  runApp(MyApp());
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = AppColor.white
    ..backgroundColor = AppColor.orange
    ..indicatorColor = AppColor.white
    ..textColor = AppColor.white
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Timer? _timer;
  final translation = Get.put(Translation());
  final drawerController = Get.put(DrawerListController());
  @override
  void initState() {
    translation.getLanguage();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        builder: EasyLoading.init(
          builder: (context, child) {
            return Scaffold(
              drawer: AppResponsive.isDesktop(context) ? null : DrawerSection(),
              key: drawerController.scaffoldKey,
              body: child,
            );
          },
        ),
        theme: ThemeData.light().copyWith(
            textTheme: GoogleFonts.cairoTextTheme(Theme.of(context).textTheme)),
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        translations: translation,
        //when start application what is a language?
        locale: Locale(translation.selectedLanguage.value),
        //when get error in language file what is language to selected ?
        fallbackLocale: Locale('en'),
        getPages: [
          // GetPage(name: '/colleges', page: () => CollegesView()),
          GetPage(name: '/login', page: () => Login()),
          GetPage(name: '/home', page: () => Home()),
          GetPage(
            name: '/collegs',
            page: () => CollegesView(),
          ),
          GetPage(name: '/permessions', page: () => PermessionView()),
          GetPage(name: '/ranks', page: () => RankView()),
          GetPage(name: '/jobs', page: () => JobView()),
          GetPage(name: '/times', page: () => TimeView()),
          GetPage(name: '/courses', page: () => CourseView()),
          GetPage(
              name: '/courseUpdate',
              page: () => CourseUpdateView(),
              transition: Transition.leftToRight,
              transitionDuration: Duration(milliseconds: 50)),
          GetPage(name: '/courseAdd', page: () => CourseAddView()),
          GetPage(name: '/departments', page: () => DepartmentView()),
          GetPage(name: '/employees', page: () => EmployeeView()),
          GetPage(name: '/addEmployee', page: () => AddEmployee()),
          GetPage(name: '/updateEmployee', page: () => UpdateEmployee()),
          GetPage(name: '/teachingMatrix', page: () => TeachingMatrixView()),
          GetPage(name: '/setting', page: () => SettingView()),
          GetPage(name: '/semester', page: () => SemesterView()),
          GetPage(
              name: '/employeeSemester', page: () => EmployeeSemesterView()),
          GetPage(name: '/classesView', page: () => ClassesView()),
          GetPage(name: '/openCourse', page: () => OpenCourse()),
          GetPage(name: '/program', page: () => ProgramView()),
          GetPage(
              name: '/openCourseReqiurement',
              page: () => OpenCourseReqiurement()),
          GetPage(name: '/graduateStudent', page: () => GraduateStudentView())
        ],
        routingCallback: (routing) {
          if (routing?.current == '/home') {
            drawerController.selectedChange(0);
          } else if (routing?.current == '/collegs') {
            drawerController.selectedChange(4);
          } else if (routing?.current == '/permessions') {
            drawerController.selectedChange(5);
          } else if (routing?.current == '/ranks') {
            drawerController.selectedChange(10);
          } else if (routing?.current == '/jobs') {
            drawerController.selectedChange(9);
          } else if (routing?.current == '/times') {
            drawerController.selectedChange(8);
          } else if (routing?.current == '/courses') {
            drawerController.selectedChange(2);
          } else if (routing?.current == '/departments') {
            drawerController.selectedChange(13);
          } else if (routing?.current == '/employees') {
            drawerController.selectedChange(1);
          } else if (routing?.current == '/teachingMatrix') {
            drawerController.selectedChange(14);
          } else if (routing?.current == '/setting') {
            drawerController.selectedChange(11);
          }
        });
  }
}
