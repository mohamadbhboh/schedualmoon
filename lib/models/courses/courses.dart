// To parse this JSON data, do
//
//     final courses = coursesFromJson(jsonString);

import 'dart:convert';

import 'package:schedualmoon/models/courses/base_courses.dart';

List<Courses> coursesFromJson(String str) =>
    List<Courses>.from(json.decode(str).map((x) => Courses.fromJson(x)));

String coursesToJson(List<Courses> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Courses extends BaseCourses {
  Courses({
    required this.id,
    required this.departmentId,
    required this.arabicName,
    required this.englishName,
    required this.totalHour,
    required this.theoriticalHour,
    required this.labHour,
    required this.year,
    required this.semester,
    required this.departmentName,
  }) : super(id: id, arabicName: arabicName, englishName: englishName);

  String id;
  int departmentId;
  String arabicName;
  String englishName;
  int totalHour;
  int theoriticalHour;
  int labHour;
  int year;
  int semester;
  String departmentName;

  factory Courses.fromJson(Map<String, dynamic> json) => Courses(
        id: json["id"],
        departmentId: json["departmentId"],
        arabicName: json["arabicName"],
        englishName: json["englishName"],
        totalHour: json["totalHour"],
        theoriticalHour: json["theoriticalHour"],
        labHour: json["labHour"],
        year: json["year"],
        semester: json["semester"],
        departmentName: json["departmentName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "departmentId": departmentId,
        "arabicName": arabicName,
        "englishName": englishName,
        "totalHour": totalHour,
        "theoriticalHour": theoriticalHour,
        "labHour": labHour,
        "year": year,
        "semester": semester,
        "departmentName": departmentName,
      };
}
