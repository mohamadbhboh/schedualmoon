// To parse this JSON data, do
//
//     final doctorOff = doctorOffFromJson(jsonString);

import 'dart:convert';

String doctorOffToJson(List<DoctorOff> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorOff {
  DoctorOff();

  List<Period> periods = <Period>[];
  String employeeId = "";

  Map<String, dynamic> toJson() => {
        "Periods": List<dynamic>.from(periods.map((x) => x.toJson())),
        "employeeId": employeeId,
      };
}

class Period {
  Period({
    required this.day,
    required this.timeFrom,
    required this.timeTo,
  });

  String day;
  String timeFrom;
  String timeTo;

  factory Period.fromJson(Map<String, dynamic> json) => Period(
        day: json["day"],
        timeFrom: json["timeFrom"],
        timeTo: json["timeTo"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "timeFrom": timeFrom,
        "timeTo": timeTo,
      };
}
