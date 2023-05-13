import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'app_color.dart';

class GeneralDialog extends StatelessWidget {
  final String title, description, image;
  final VoidCallback positivePress;
  GeneralDialog(
      {required this.title,
      required this.description,
      required this.positivePress,
      required this.image});
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
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: positivePress,
                  child: Text(
                    'ok'.tr,
                    style: TextStyle(fontSize: 20.0, color: AppColor.greenEdit),
                  ),
                ),
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
            child: ClipRRect(
              child: Image(
                image: AssetImage(image),
              ),
              borderRadius: BorderRadius.circular(40),
            ),
            backgroundColor: AppColor.blue,
          ),
        )
      ],
    );
  }
}
