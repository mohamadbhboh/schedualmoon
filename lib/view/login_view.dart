import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:schedualmoon/component/app_color.dart';
import 'package:schedualmoon/component/translations.dart';
import 'package:schedualmoon/controllers/login_controller.dart';
import 'package:schedualmoon/component/text_box.dart';
import 'package:schedualmoon/models/login.dart';
import 'package:universal_html/html.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final loginEmployee = Get.put(LoginControllar());
    final translation = Get.put(Translation());

    final GlobalKey<FormState> formValidLogin = new GlobalKey<FormState>();
    TextEditingController emailController = new TextEditingController();
    TextEditingController passwordController = new TextEditingController();
    login() async {
      if (formValidLogin.currentState!.validate()) {
        EmployeeLogin result =
            await loginEmployee.getLoginemployee(emailController.text);
        if (result.toString() != "") {
          if (passwordController.text ==
              loginEmployee.employeeLogin!.password) {
            Storage localStorage = window.localStorage;
            localStorage['dept'] = result.departmentId;
            Get.toNamed('/home');
          } else {
            print("hi");
            EasyLoading.showError('passwordError'.tr);
          }
        }
      }
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              child: Row(
                children: [
                  //first section of page
                  Column(
                    children: [
                      Container(
                        color: AppColor.white,
                        height: MediaQuery.of(context).size.height / 2,
                        width: width / 4,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        height: MediaQuery.of(context).size.height / 2,
                        color: Colors.white,
                        child: CustomPaint(painter: FaceOutlinePainter()),
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.white,
                      padding: translation.selectedLanguage.value == "ar"
                          ? EdgeInsets.only(left: 50, top: 20)
                          : EdgeInsets.only(top: 20, left: 50),
                      child: Text(
                        ("welcome".tr),
                        style: TextStyle(
                            fontSize: width > 1150 ? 25 : 15,
                            fontWeight: FontWeight.bold,
                            color: AppColor.lighteOrange),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        height: MediaQuery.of(context).size.height / 2,
                        color: Colors.white,
                        child: CustomPaint(painter: FaceOutlinePainter2()),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        height: MediaQuery.of(context).size.height / 2,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 130),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColor.white,
                        AppColor.bluelight,
                      ],
                      stops: [
                        0.2,
                        1,
                      ],
                    ),
                  ),
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width / 10 + 20,
                  ),
                  padding: EdgeInsets.only(left: 70),
                  height: MediaQuery.of(context).size.width / 2,
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Form(
                    key: formValidLogin,
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 4,
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Icon(
                                    Icons.account_circle_sharp,
                                    size: width > 650 ? 100 : 30,
                                    color: AppColor.blue,
                                  ),
                                ),
                                Container(
                                  child: Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: TextBox(
                                          isPassword: false,
                                          mxaLength: 50,
                                          name: "employeeId".tr,
                                          controllarName: emailController,
                                          myicon: Icons.account_circle,
                                          inputvalid: (value) {
                                            if (value == "") {
                                              return 'textBoxValidIsEmpty'.tr;
                                            }
                                          },
                                          isNumber: false)),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: width > 1150 ? 20 : 10,
                                      bottom: width > 1150 ? 20 : 10),
                                  child: Container(
                                    child: TextBox(
                                        isPassword: true,
                                        mxaLength: 30,
                                        name: "password".tr,
                                        controllarName: passwordController,
                                        myicon: Icons.lock,
                                        inputvalid: (value) {
                                          if (value!.length < 8) {
                                            return 'passwordValid'.tr;
                                          }
                                        },
                                        isNumber: false),
                                  ),
                                ),
                                Container(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      {
                                        login();
                                      }
                                    },
                                    child: Text(
                                      "login".tr,
                                      style: TextStyle(
                                          color: AppColor.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              18.0)), //CircleBorder(),
                                      padding: EdgeInsets.all(10),
                                      primary: AppColor.blue,
                                      onPrimary: Colors.orange,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: AppColor.white,
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 14),
                          width: MediaQuery.of(context).size.width / 2.8,
                          height: MediaQuery.of(context).size.width / 2,
                          child: Image.asset(
                            'images/schedual.gif',
                            height: 60.0,
                            fit: BoxFit.fill,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Image.asset(
                'images/kalamoon.jpg',
                width: width > 1150 ? 150 : 80,
                height: width > 1150 ? 150 : 80,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FaceOutlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Gradient gradient1 = new LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [AppColor.blue, AppColor.blueAvg],
      tileMode: TileMode.clamp,
    );
    final Rect colorBounds = Rect.fromLTRB(0, 0, size.width, size.height);
    final Paint paint = new Paint()
      ..shader = gradient1.createShader(colorBounds);

    Path path = Path();
    path.moveTo(0, 0); //Ax, Ay
    path.relativeCubicTo(size.width, size.height / 2, size.width / 1.3,
        size.height / 1.3, size.width, size.height);
    path.lineTo(0, size.height); //Bx, By, Cx, Cy
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(FaceOutlinePainter oldDelegate) => false;
}

class FaceOutlinePainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Gradient gradient1 = new LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [AppColor.blue, AppColor.blueAvg],
      tileMode: TileMode.clamp,
    );
    final Rect colorBounds = Rect.fromLTRB(0, 0, size.width, size.height);
    final Paint paint = new Paint()
      ..shader = gradient1.createShader(colorBounds);

    Path path = Path();
    path.moveTo(0, 0); //Ax, Ay
    path.relativeCubicTo(size.width / 3.5, size.height / 1.8, size.width / 6,
        size.height / 2.5, size.width, size.height);
    path.lineTo(size.width, 0); //Bx, By, Cx, Cy
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(FaceOutlinePainter2 oldDelegate) => false;
}
