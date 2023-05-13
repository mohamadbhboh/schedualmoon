// To parse this JSON data, do
//
//     final classes = classesFromJson(jsonString);

import 'dart:convert';

List<Classes> classesFromJson(String str) =>
    List<Classes>.from(json.decode(str).map((x) => Classes.fromJson(x)));

String classesToJson(List<Classes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Classes {
  Classes({
    required this.classId,
    required this.studentCount,
    required this.classLapOrNot,
    required this.employeeId,
    required this.employeeName,
    required this.semesterCourseId,
    required this.departmentId,
    required this.hourNumber,
    required this.courseId,
    required this.arName,
    required this.enName,
    required this.totalHour,
    required this.theoryHour,
    required this.lapHour,
    required this.year,
    required this.semester,
    required this.classNumber,
  });

  String classId;
  String studentCount;
  String classLapOrNot;
  String employeeId;
  String employeeName;
  String semesterCourseId;
  String departmentId;
  String hourNumber;
  String courseId;
  String arName;
  String enName;
  String totalHour;
  String theoryHour;
  String lapHour;
  String year;
  String semester;
  String classNumber;
  //each row store in database have status=1
  int rowStatus = 1;

  factory Classes.fromJson(Map<String, dynamic> json) => Classes(
        classId: json["classId"],
        studentCount: json["studentCount"],
        classLapOrNot: json["classLapOrNot"],
        employeeId: json["employeeId"],
        employeeName: json["employeeName"],
        semesterCourseId: json["semesterCourseId"],
        departmentId: json["departmentId"],
        hourNumber: json["hourNumber"],
        courseId: json["courseId"],
        arName: json["arName"],
        enName: json["enName"],
        totalHour: json["totalHour"],
        theoryHour: json["theoryHour"],
        lapHour: json["lapHour"],
        year: json["year"],
        semester: json["semester"],
        classNumber: json["classNumber"],
      );

  Map<String, dynamic> toJson() => {
        "classId": classId,
        "studentCount": studentCount,
        "classLapOrNot": classLapOrNot,
        "employeeId": employeeId,
        "employeeName": employeeName,
        "semesterCourseId": semesterCourseId,
        "departmentId": departmentId,
        "hourNumber": hourNumber,
        "courseId": courseId,
        "arName": arName,
        "enName": enName,
        "totalHour": totalHour,
        "theoryHour": theoryHour,
        "lapHour": lapHour,
        "year": year,
        "semester": semester,
        "classNumber": classNumber,
      };
}
