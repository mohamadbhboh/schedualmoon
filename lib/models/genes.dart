// To parse this JSON data, do
//
//     final genes = genesFromJson(jsonString);

import 'dart:convert';

List<Genes> genesFromJson(String str) =>
    List<Genes>.from(json.decode(str).map((x) => Genes.fromJson(x)));

String genesToJson(List<Genes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Genes {
  Genes({
    required this.classId,
    required this.doctorId,
    required this.hour,
    required this.year,
    required this.semester,
    required this.classNumber,
    required this.day,
    required this.timeFrom,
    required this.timeTo,
  });

  String classId;
  String doctorId;
  String hour;
  String year;
  String semester;
  String classNumber;
  int day;
  String timeFrom;
  String timeTo;

  factory Genes.fromJson(Map<String, dynamic> json) => Genes(
        classId: json["classId"],
        doctorId: json["doctorId"],
        hour: json["hour"],
        year: json["year"],
        semester: json["semester"],
        classNumber: json["classNumber"],
        day: json["day"],
        timeFrom: json["timeFrom"],
        timeTo: json["timeTo"],
      );

  Map<String, dynamic> toJson() => {
        "classId": classId,
        "doctorId": doctorId,
        "hour": hour,
        "year": year,
        "semester": semester,
        "classNumber": classNumber,
        "day": day,
        "timeFrom": timeFrom,
        "timeTo": timeTo,
      };
}
