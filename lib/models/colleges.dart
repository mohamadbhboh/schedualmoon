// To parse this JSON data, do
//
//     final colleges = collegesFromJson(jsonString);

import 'dart:convert';

List<Colleges> collegesFromJson(String str) =>
    List<Colleges>.from(json.decode(str).map((x) => Colleges.fromJson(x)));

String collegesToJson(List<Colleges> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Colleges {
  Colleges({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory Colleges.fromJson(Map<String, dynamic> json) => Colleges(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
