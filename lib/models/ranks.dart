// To parse this JSON data, do
//
//     final ranks = ranksFromJson(jsonString);

import 'dart:convert';

List<Ranks> ranksFromJson(String str) =>
    List<Ranks>.from(json.decode(str).map((x) => Ranks.fromJson(x)));

String ranksToJson(List<Ranks> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ranks {
  Ranks({
    required this.id,
    required this.name,
    required this.hourNumber,
  });

  String id;
  String name;
  String hourNumber;

  factory Ranks.fromJson(Map<String, dynamic> json) => Ranks(
        id: json["id"],
        name: json["name"],
        hourNumber: json["hourNumber"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "hourNumber": hourNumber,
      };
}
