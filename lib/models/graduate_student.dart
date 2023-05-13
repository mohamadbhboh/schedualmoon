// To parse this JSON data, do
//
//     final graduateStudent = graduateStudentFromJson(jsonString);

import 'dart:convert';

List<GraduateStudent> graduateStudentFromJson(String str) =>
    List<GraduateStudent>.from(
        json.decode(str).map((x) => GraduateStudent.fromJson(x)));

String graduateStudentToJson(List<GraduateStudent> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GraduateStudent {
  GraduateStudent({
    required this.studentId,
    required this.name,
    required this.courseId,
    required this.arName,
    required this.enName,
    required this.questionId,
  });

  String studentId;
  String name;
  String courseId;
  String arName;
  String enName;
  String questionId;

  factory GraduateStudent.fromJson(Map<String, dynamic> json) =>
      GraduateStudent(
        studentId: json["studentId"],
        name: json["name"],
        courseId: json["courseId"],
        arName: json["arName"],
        enName: json["enName"],
        questionId: json["questionId"],
      );

  Map<String, dynamic> toJson() => {
        "studentId": studentId,
        "name": name,
        "courseId": courseId,
        "arName": arName,
        "enName": enName,
        "questionId": questionId,
      };
}
