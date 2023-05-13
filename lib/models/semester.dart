// To parse this JSON data, do
//
//     final semesters = semestersFromJson(jsonString);

import 'dart:convert';

List<Semesters> semestersFromJson(String str) =>
    List<Semesters>.from(json.decode(str).map((x) => Semesters.fromJson(x)));

String semestersToJson(List<Semesters> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Semesters {
  Semesters({
    required this.id,
    required this.year,
    required this.semester,
  });

  String id;
  String year;
  String semester;

  factory Semesters.fromJson(Map<String, dynamic> json) => Semesters(
        id: json["id"],
        year: json["year"],
        semester: json["semester"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "year": year,
        "semester": semester,
      };
}
