// To parse this JSON data, do
//
//     final teachHour = teachHourFromJson(jsonString);

import 'dart:convert';

List<TeachHour> teachHourFromJson(String str) =>
    List<TeachHour>.from(json.decode(str).map((x) => TeachHour.fromJson(x)));

String teachHourToJson(List<TeachHour> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeachHour {
  TeachHour({
    required this.employeeId,
    required this.hourNumber,
  });

  int employeeId;
  int hourNumber;
  int hourClasses = 0;
  factory TeachHour.fromJson(Map<String, dynamic> json) => TeachHour(
        employeeId: json["employeeId"],
        hourNumber: json["hourNumber"],
      );

  Map<String, dynamic> toJson() => {
        "employeeId": employeeId,
        "hourNumber": hourNumber,
      };
}
