// To parse this JSON data, do
//
//     final students = studentsFromJson(jsonString);

import 'dart:convert';

List<Students> studentsFromJson(String str) =>
    List<Students>.from(json.decode(str).map((x) => Students.fromJson(x)));

String studentsToJson(List<Students> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Students {
  Students({
    required this.studentId,
    required this.name,
  });

  String studentId;
  String name;

  factory Students.fromJson(Map<String, dynamic> json) => Students(
        studentId: json["studentId"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "studentId": studentId,
        "name": name,
      };
}
