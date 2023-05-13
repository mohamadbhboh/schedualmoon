// To parse this JSON data, do
//
//     final teachingMatrixMenuItem = teachingMatrixMenuItemFromJson(jsonString);
//this class for Dropdownmenuitem for teaching matrix
//using in classes view
import 'dart:convert';

List<TeachingMatrixMenuItem> teachingMatrixMenuItemFromJson(String str) =>
    List<TeachingMatrixMenuItem>.from(
        json.decode(str).map((x) => TeachingMatrixMenuItem.fromJson(x)));

String teachingMatrixMenuItemToJson(List<TeachingMatrixMenuItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeachingMatrixMenuItem {
  TeachingMatrixMenuItem({
    required this.employeeId,
    required this.employeeName,
  });

  String employeeId;
  String employeeName;

  factory TeachingMatrixMenuItem.fromJson(Map<String, dynamic> json) =>
      TeachingMatrixMenuItem(
        employeeId: json["employeeId"],
        employeeName: json["employeeName"],
      );

  Map<String, dynamic> toJson() => {
        "employeeId": employeeId,
        "employeeName": employeeName,
      };
}
