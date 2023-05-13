import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:schedualmoon/component/app_color.dart';

class ConfirmDialog extends StatelessWidget {
  final String title, description;
  final VoidCallback positivePress, cancelPrsee;
  final IconData icon;
  final Color iconColor;
  ConfirmDialog(
      {required this.title,
      required this.description,
      required this.positivePress,
      required this.cancelPrsee,
      required this.icon,
      required this.iconColor});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContext(context),
    );
  }

  dialogContext(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 400,
          padding: EdgeInsets.only(top: 100, bottom: 16, left: 16, right: 16),
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: Colors.blueAccent, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                )
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                description,
                style: TextStyle(fontSize: 24.0),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: positivePress,
                        child: Text(
                          "confirm".tr,
                          style: TextStyle(
                              fontSize: 20, color: AppColor.greenEdit),
                        )),
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: cancelPrsee,
                        child: Text(
                          "cancel".tr,
                          style: TextStyle(
                              fontSize: 20.0, color: AppColor.redDelete),
                        )),
                  )
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 16,
          right: 16,
          child: CircleAvatar(
            radius: 50,
            child: Icon(
              icon,
              size: 45,
              color: iconColor,
            ),
          ),
        )
      ],
    );
  }
}
