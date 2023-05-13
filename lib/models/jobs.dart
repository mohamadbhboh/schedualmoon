// To parse this JSON data, do
//
//     final jobs = jobsFromJson(jsonString);

import 'dart:convert';

List<Jobs> jobsFromJson(String str) =>
    List<Jobs>.from(json.decode(str).map((x) => Jobs.fromJson(x)));

String jobsToJson(List<Jobs> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Jobs {
  Jobs({
    required this.id,
    required this.name,
    required this.hourDiscount,
  });

  String id;
  String name;
  String hourDiscount;

  factory Jobs.fromJson(Map<String, dynamic> json) => Jobs(
        id: json["id"],
        name: json["name"],
        hourDiscount: json["hourDiscount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "hourDiscount": hourDiscount,
      };
}
