import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:schedualmoon/component/app_color.dart';

class IconTextBox extends StatelessWidget {
  final TextEditingController controllarName;
  final name;
  final IconData myicon;
  final FormFieldValidator<String> inputvalid;
  final int mxaLength;
  final isPassword;
  final VoidCallback iconPress;
  IconTextBox(
      {required this.iconPress,
      required this.isPassword,
      required this.mxaLength,
      required this.name,
      required this.controllarName,
      required this.myicon,
      required this.inputvalid});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //if true then hide letters
      obscureText: isPassword,
      maxLength: mxaLength,
      controller: controllarName,
      textAlign: TextAlign.center,
      validator: inputvalid,
      decoration: InputDecoration(
          icon: IconButton(
            icon: Icon(myicon),
            tooltip: 'editCollege'.tr,
            onPressed: iconPress,
            //color: AppColor.orange,
          ),
          labelText: name,
          labelStyle: TextStyle(color: AppColor.orange),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(color: AppColor.black, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(color: AppColor.black),
          )),
    );
  }
}
