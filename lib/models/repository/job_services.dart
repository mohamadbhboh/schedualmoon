import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:schedualmoon/models/jobs.dart';
import 'package:schedualmoon/shared/database_url.dart';

class JobRepository {
  static var client = http.Client();
  static Future getJobs() async {
    var url = Uri.parse(Database.jobRead);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var jsonString = utf8.decode(response.bodyBytes);
      return jobsFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future deleteJobs(String id) async {
    var url = Uri.parse(Database.deleteJob);
    var data = jsonEncode(<String, String>{"id": id});
    var responce = await http.post(url, body: data);
    return responce.body;
  }

  static Future editJob(String id, String name, String hourDiscount) async {
    var url = Uri.parse(Database.updateJob);
    var data = jsonEncode(
        <String, String>{"id": id, "name": name, "hourDiscount": hourDiscount});
    var responce = await http.post(url, body: data);
    return responce.body;
  }

  static Future addJob(String name, String hourDiscount) async {
    var url = Uri.parse(Database.createRank);
    var data = jsonEncode(
        <String, String>{"name": name, "hourDiscount": hourDiscount});
    var responce = await http.post(url, body: data);
    return responce.body;
  }
}
