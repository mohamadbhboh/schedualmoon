// To parse this JSON data, do
//
//     final departmentTeachingMatrix = departmentTeachingMatrixFromJson(jsonString);

import 'dart:convert';

List<DepartmentTeachingMatrix> departmentTeachingMatrixFromJson(String str) =>
    List<DepartmentTeachingMatrix>.from(
        json.decode(str).map((x) => DepartmentTeachingMatrix.fromJson(x)));

String departmentTeachingMatrixToJson(List<DepartmentTeachingMatrix> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DepartmentTeachingMatrix {
  DepartmentTeachingMatrix({
    required this.id,
    required this.employeeId,
    required this.courseId,
    required this.name,
  });

  String id;
  String employeeId;
  String courseId;
  String name;

  factory DepartmentTeachingMatrix.fromJson(Map<String, dynamic> json) =>
      DepartmentTeachingMatrix(
        id: json["id"],
        employeeId: json["employeeId"],
        courseId: json["courseId"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employeeId": employeeId,
        "courseId": courseId,
        "name": name,
      };
}
