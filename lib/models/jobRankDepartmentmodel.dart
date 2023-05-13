// To parse this JSON data, do
//
//     final jobRankDepartmentModel = jobRankDepartmentModelFromJson(jsonString);

import 'dart:convert';

JobRankDepartmentModel jobRankDepartmentModelFromJson(String str) =>
    JobRankDepartmentModel.fromJson(json.decode(str));

String jobRankDepartmentModelToJson(JobRankDepartmentModel data) =>
    json.encode(data.toJson());

class JobRankDepartmentModel {
  JobRankDepartmentModel({
    required this.jobs,
    required this.ranks,
    required this.department,
  });

  List<Job> jobs;
  List<Rank> ranks;
  List<Department> department;

  factory JobRankDepartmentModel.fromJson(Map<String, dynamic> json) =>
      JobRankDepartmentModel(
        jobs: List<Job>.from(json["jobs"].map((x) => Job.fromJson(x))),
        ranks: List<Rank>.from(json["ranks"].map((x) => Rank.fromJson(x))),
        department: List<Department>.from(
            json["department"].map((x) => Department.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "jobs": List<dynamic>.from(jobs.map((x) => x.toJson())),
        "ranks": List<dynamic>.from(ranks.map((x) => x.toJson())),
        "department": List<dynamic>.from(department.map((x) => x.toJson())),
      };
}

class Department {
  Department({
    required this.id,
    required this.name,
    required this.collegeId,
  });

  String id;
  String name;
  String collegeId;

  factory Department.fromJson(Map<String, dynamic> json) => Department(
        id: json["id"],
        name: json["name"],
        collegeId: json["collegeId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "collegeId": collegeId,
      };
}

class Job {
  Job({
    required this.id,
    required this.name,
    required this.hourDiscount,
  });

  String id;
  String name;
  String hourDiscount;

  factory Job.fromJson(Map<String, dynamic> json) => Job(
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

class Rank {
  Rank({
    required this.id,
    required this.name,
    required this.hourNumber,
  });

  String id;
  String name;
  String hourNumber;

  factory Rank.fromJson(Map<String, dynamic> json) => Rank(
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
