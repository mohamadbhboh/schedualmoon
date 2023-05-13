import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:schedualmoon/shared/database_url.dart';
import 'package:schedualmoon/models/semester.dart';

class SemesterRepository {
  static var client = http.Client();
  static Future getSemesters() async {
    var url = Uri.parse(Database.semesterRead);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var jsonString = utf8.decode(response.bodyBytes);
      return semestersFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future editSemester(String id, String semester, String year) async {
    var url = Uri.parse(Database.semesterUpdate);
    var data = jsonEncode(
        <String, String>{"id": id, "year": year, "semester": semester});
    var responce = await http.post(url, body: data);
    return responce.body;
  }

  static Future deleteSemester(String id) async {
    var url = Uri.parse(Database.semesterDelete);
    var data = jsonEncode(<String, String>{"id": id});
    var response = await http.post(url, body: data);
    return response.body;
  }

  static Future addSemester(String _semester, String _year) async {
    var url = Uri.parse(Database.addSemester);
    var data =
        jsonEncode(<String, String>{"year": _year, "semester": _semester});
    var response = await http.post(url, body: data);
    return response.body;
  }
}
