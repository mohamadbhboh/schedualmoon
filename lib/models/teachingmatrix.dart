// To parse this JSON data, do
//
//     final teachingMatrix = teachingMatrixFromJson(jsonString);

import 'dart:convert';

List<TeachingMatrix> teachingMatrixFromJson(String str) =>
    List<TeachingMatrix>.from(
        json.decode(str).map((x) => TeachingMatrix.fromJson(x)));

String teachingMatrixToJson(List<TeachingMatrix> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeachingMatrix {
  TeachingMatrix({
    required this.id,
    required this.employeeId,
    required this.courseId,
  });

  String id;
  String employeeId;
  String courseId;

  factory TeachingMatrix.fromJson(Map<String, dynamic> json) => TeachingMatrix(
        id: json["id"],
        employeeId: json["employeeId"],
        courseId: json["courseId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employeeId": employeeId,
        "courseId": courseId,
      };
}
