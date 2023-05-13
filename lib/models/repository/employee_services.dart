import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:schedualmoon/models/employees.dart';
import 'package:schedualmoon/shared/database_url.dart';

class EmployeeRepository {
  static var client = http.Client();
  static Future getEmployees() async {
    var url = Uri.parse(Database.employeeRead);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var jsonString = utf8.decode(response.bodyBytes);
      return employeesFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future deleteEmployee(String id) async {
    var url = Uri.parse(Database.deleteEmployee);
    var data = jsonEncode(<String, String>{"id": id});
    var responce = await http.post(url, body: data);
    return responce.body;
  }

  static Future editEmployee(
      String id,
      String name,
      String departmentId,
      String jobId,
      String rankId,
      String type,
      String contracted,
      String password,
      String employeeMembership) async {
    var url = Uri.parse(Database.updateEmployee);
    var data = jsonEncode(<String, String>{
      "id": id,
      "name": name,
      "password": password,
      "departmentId": departmentId,
      "jobId": jobId,
      "rankId": rankId,
      "employeeMembership": employeeMembership,
      "contracted": contracted,
      "type": type
    });
    var responce = await http.post(url, body: data);
    return responce.body;
  }

  static Future addEmployee(
    String name,
    String password,
    String departmentId,
    String jobId,
    String rankId,
    String type,
    String cotracted,
    String membership,
  ) async {
    var url = Uri.parse(Database.createEmployee);
    var data = jsonEncode(<String, String>{
      "name": name,
      "password": password,
      "departmentId": departmentId,
      "jobId": jobId,
      "rankId": rankId,
      "employeeMembership": membership,
      "type": type,
      "contracted": cotracted,
    });
    var responce = await http.post(url, body: data);
    return responce.body;
  }
}
