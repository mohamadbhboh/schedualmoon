// To parse this JSON data, do
//
//     final timeClasses = timeClassesFromJson(jsonString);

import 'dart:convert';

List<TimeClasses> timeClassesFromJson(String str) => List<TimeClasses>.from(
    json.decode(str).map((x) => TimeClasses.fromJson(x)));

String timeClassesToJson(List<TimeClasses> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TimeClasses {
  TimeClasses({
    required this.hour,
    required this.allBasicTime,
  });

  String hour;
  List<AllBasicTime> allBasicTime;

  factory TimeClasses.fromJson(Map<String, dynamic> json) => TimeClasses(
        hour: json["hour"],
        allBasicTime: List<AllBasicTime>.from(
            json["allBasicTime"].map((x) => AllBasicTime.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "hour": hour,
        "allBasicTime": List<dynamic>.from(allBasicTime.map((x) => x.toJson())),
      };
}

class AllBasicTime {
  AllBasicTime({
    required this.id,
    required this.time,
  });

  String id;
  String time;

  factory AllBasicTime.fromJson(Map<String, dynamic> json) => AllBasicTime(
        id: json["id"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "time": time,
      };
}
