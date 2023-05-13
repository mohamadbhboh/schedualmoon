// To parse this JSON data, do
//
//     final employees = employeesFromJson(jsonString);

import 'dart:convert';

List<Employees> employeesFromJson(String str) =>
    List<Employees>.from(json.decode(str).map((x) => Employees.fromJson(x)));

String employeesToJson(List<Employees> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Employees {
  Employees({
    required this.id,
    required this.name,
    required this.password,
    required this.departmentId,
    required this.jobId,
    required this.rankId,
    required this.type,
    required this.contracted,
    required this.employeeMembership,
    required this.departmentName,
    required this.rankName,
    required this.jobName,
  });

  String id;
  String name;
  String password;
  String departmentId;
  String jobId;
  String rankId;
  String type;
  String contracted;
  String employeeMembership;
  String departmentName;
  String rankName;
  String jobName;

  factory Employees.fromJson(Map<String, dynamic> json) => Employees(
        id: json["id"],
        name: json["name"],
        password: json["password"],
        departmentId: json["departmentId"],
        jobId: json["jobId"],
        rankId: json["rankId"],
        type: json["type"],
        contracted: json["contracted"],
        employeeMembership: json["employeeMembership"],
        departmentName: json["departmentName"],
        rankName: json["rankName"],
        jobName: json["jobName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "password": password,
        "departmentId": departmentId,
        "jobId": jobId,
        "rankId": rankId,
        "type": type,
        "contracted": contracted,
        "employeeMembership": employeeMembership,
        "departmentName": departmentName,
        "rankName": rankName,
        "jobName": jobName,
      };
}
