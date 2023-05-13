// To parse this JSON data, do
//
//     final departments = departmentsFromJson(jsonString);

import 'dart:convert';

List<Departments> departmentsFromJson(String str) => List<Departments>.from(
    json.decode(str).map((x) => Departments.fromJson(x)));

String departmentsToJson(List<Departments> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Departments {
  Departments({
    required this.id,
    required this.collegeId,
    required this.name,
    required this.collegeName,
  });

  int id;
  int collegeId;
  String name;
  String collegeName;

  factory Departments.fromJson(Map<String, dynamic> json) => Departments(
        id: json["id"],
        collegeId: json["collegeId"],
        name: json["name"],
        collegeName: json["collegeName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "collegeId": collegeId,
        "name": name,
        "collegeName": collegeName,
      };
}
