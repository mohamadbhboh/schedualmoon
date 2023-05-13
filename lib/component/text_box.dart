import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schedualmoon/component/app_color.dart';

class TextBox extends StatelessWidget {
  final TextEditingController controllarName;
  final name;
  final IconData myicon;
  final FormFieldValidator<String> inputvalid;
  final int mxaLength;
  final bool isPassword;
  final bool isNumber;
  TextBox(
      {required this.isPassword,
      required this.mxaLength,
      required this.name,
      required this.controllarName,
      required this.myicon,
      required this.inputvalid,
      required this.isNumber});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //if true then hide letters
      inputFormatters: [
        if (isNumber) FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
      ],
      obscureText: isPassword,
      maxLength: mxaLength,
      controller: controllarName,
      textAlign: TextAlign.center,
      validator: inputvalid,
      decoration: InputDecoration(
          icon: Icon(
            myicon,
            color: AppColor.orange,
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
