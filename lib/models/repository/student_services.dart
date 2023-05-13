import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:schedualmoon/shared/database_url.dart';
import 'package:schedualmoon/models/students.dart';

class StudentServices {
  static var client = http.Client();
  static Future getGraduateStudent(String departmentId) async {
    var url = Uri.parse(Database.graduateStudentRead);
    var data = jsonEncode(<String, String>{"departmentId": departmentId});
    var response = await http.post(url, body: data);
    var jsonString = utf8.decode(response.bodyBytes);
    return studentsFromJson(jsonString);
  }
}
