import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:schedualmoon/shared/database_url.dart';
import 'package:schedualmoon/models/graduate_student.dart';

class GraduateStudentServices {
  static var client = http.Client();
  static Future getGraduateStudent(
      String semesterId, String departmentId) async {
    var url = Uri.parse(Database.graduateStdRead);
    var data = jsonEncode(<String, String>{
      'semesterId': semesterId,
      'departmentId': departmentId
    });
    var response = await http.post(url, body: data);
    var jsonString = utf8.decode(response.bodyBytes);
    return graduateStudentFromJson(jsonString);
  }

  static Future deleteGraduateQuestion(
      String questionId, String studentId) async {
    var url = Uri.parse(Database.deleteGraduateCourse);
    var data = jsonEncode(
        <String, String>{'questionId': questionId, 'studentId': studentId});
    var response = await http.post(url, body: data);
    return response.body;
  }

  static Future addGraduateCourse(String departmentId, String semesterId,
      String studentId, String courseId) async {
    var url = Uri.parse(Database.addGraduateCourse);
    var data = jsonEncode(<String, String>{
      'departmentId': departmentId,
      'semesterId': semesterId,
      'studentId': studentId,
      'courseId': courseId
    });
    var response = await http.post(url, body: data);
    //student answer id an return value
    return response.body;
  }
}
