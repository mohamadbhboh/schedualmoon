import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:schedualmoon/shared/database_url.dart';
import 'package:schedualmoon/models/teachingmatrix.dart';

class TachingMatrixRepositroy {
  static var client = http.Client();

  static Future getTeachingMatrix() async {
    var url = Uri.parse(Database.teachingMatrixRead);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var jsonString = utf8.decode(response.bodyBytes);
      return teachingMatrixFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future addTeachingMatrix(String employeeId, String courseId) async {
    var url = Uri.parse(Database.teachingMatrixCreate);
    var data = jsonEncode(
        <String, String>{"employeeId": employeeId, "courseId": courseId});
    var response = await http.post(url, body: data);
    return response.body;
  }

  static Future deleteTeachingMatrix(String id) async {
    var url = Uri.parse(Database.teachingMatrixDelete);
    var data = jsonEncode(<String, String>{"id": id});
    var response = await http.post(url, body: data);
    return response.body;
  }
}
