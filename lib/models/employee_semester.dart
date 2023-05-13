// To parse this JSON data, do
//
//     final employeeSemesters = employeeSemestersFromJson(jsonString);

import 'dart:convert';

List<EmployeeSemesters> employeeSemestersFromJson(String str) =>
    List<EmployeeSemesters>.from(
        json.decode(str).map((x) => EmployeeSemesters.fromJson(x)));

String employeeSemestersToJson(List<EmployeeSemesters> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeeSemesters {
  EmployeeSemesters({
    required this.employeeId,
    required this.employeeName,
    required this.employeeSemesterId,
    required this.fullTime,
    required this.days,
  });

  int employeeId;
  String employeeName;
  int employeeSemesterId;
  int fullTime;
  Days days;

  factory EmployeeSemesters.fromJson(Map<String, dynamic> json) =>
      EmployeeSemesters(
        employeeId: json["employeeId"],
        employeeName: json["employeeName"],
        employeeSemesterId: json["employeeSemesterId"],
        fullTime: json["fullTime"],
        days: Days.fromJson(json["days"]),
      );

  Map<String, dynamic> toJson() => {
        "employeeId": employeeId,
        "employeeName": employeeName,
        "employeeSemesterId": employeeSemesterId,
        "fullTime": fullTime,
        "days": days.toJson(),
      };
}

class Days {
  Days({
    required this.sa,
    required this.su,
    required this.mo,
    required this.tu,
    required this.we,
  });

  int sa;
  int su;
  int mo;
  int tu;
  int we;

  factory Days.fromJson(Map<String, dynamic> json) => Days(
        sa: json["sa"],
        su: json["su"],
        mo: json["mo"],
        tu: json["tu"],
        we: json["we"],
      );

  Map<String, dynamic> toJson() => {
        "sa": sa,
        "su": su,
        "mo": mo,
        "tu": tu,
        "we": we,
      };
}
