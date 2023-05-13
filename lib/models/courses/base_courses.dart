import 'dart:convert';

List<BaseCourses> baseCoursesFromJson(String str) => List<BaseCourses>.from(
    json.decode(str).map((x) => BaseCourses.fromJson(x)));

String baseCoursesToJson(List<BaseCourses> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BaseCourses {
  String id;
  String arabicName;
  String englishName;
  BaseCourses(
      {required this.id, required this.arabicName, required this.englishName});

  factory BaseCourses.fromJson(Map<String, dynamic> json) => BaseCourses(
        id: json["id"],
        arabicName: json["arabicName"],
        englishName: json["englishName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "arabicName": arabicName,
        "englishName": englishName,
      };
}
