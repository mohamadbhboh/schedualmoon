import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:schedualmoon/models/employee_semester.dart';
import 'package:schedualmoon/shared/database_url.dart';

class EmployeeSemesterRepository {
  static var client = http.Client();

  static Future getEmployeeSemester(
      String semesterId, String departmentId) async {
    var url = Uri.parse(Database.employeeSemesterRead);
    var data = jsonEncode(<String, String>{
      "semesterId": semesterId,
      "departmentId": departmentId
    });
    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      var jsonString = utf8.decode(response.bodyBytes);
      return employeeSemestersFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future createEmployeeSemester(
      String employeeId, String semesterId, String fullTime) async {
    var url = Uri.parse(Database.employeeSemesterCreate);
    var data = jsonEncode(<String, String>{
      "semesterId": semesterId,
      "employeeId": employeeId,
      "fullTime": fullTime
    });
    var responce = await http.post(url, body: data);
    return responce.body;
  }

  static Future createEmployeeSemesterDay(
      String day, String employeeSemesterId) async {
    var url = Uri.parse(Database.employeeSemesterDayCreate);
    var data = jsonEncode(
        <String, String>{"day": day, "employeeSemesterId": employeeSemesterId});
    var response = await http.post(url, body: data);
    return response.body;
  }

  static Future deleteEmployeeSemesterDay(
      String day, String employeeSemesterId) async {
    var url = Uri.parse(Database.employeeSemesterDayDelete);
    var data = jsonEncode(
        <String, String>{"day": day, "employeeSemesterId": employeeSemesterId});
    var response = await http.post(url, body: data);
    return response.body;
  }

  static Future updateEmployeeSemester(String employeeSemesterId,
      String semesterId, String employeeId, String fullTime) async {
    var url = Uri.parse(Database.employeeSemesterUpdate);
    var data = jsonEncode(<String, String>{
      "id": employeeSemesterId,
      "semesterId": semesterId,
      "employeeId": employeeId,
      "fullTime": fullTime
    });
    var response = await http.post(url, body: data);
    return response.body;
  }
}
