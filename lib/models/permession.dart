// To parse this JSON data, do
//
//     final permession = permessionFromJson(jsonString);

import 'dart:convert';

List<Permession> permessionFromJson(String str) =>
    List<Permession>.from(json.decode(str).map((x) => Permession.fromJson(x)));

String permessionToJson(List<Permession> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Permession {
  Permession({
    required this.id,
    required this.name,
    required this.create,
    required this.read,
    required this.update,
    required this.delete,
    required this.department,
  });

  String id;
  String name;
  bool create;
  bool read;
  bool update;
  bool delete;
  String department;

  factory Permession.fromJson(Map<String, dynamic> json) => Permession(
        id: json["id"],
        name: json["name"],
        create: json["create"],
        read: json["read"],
        update: json["update"],
        delete: json["delete"],
        department: json["department"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "create": create,
        "read": read,
        "update": update,
        "delete": delete,
        "department": department,
      };
}
