import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:schedualmoon/models/departments.dart';
import 'package:schedualmoon/shared/database_url.dart';

class DepartmentRepository {
  static var client = http.Client();
  static Future getDepartments() async {
    var url = Uri.parse(Database.departmentRead);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var jsonString = utf8.decode(response.bodyBytes);
      return departmentsFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future addDepartments(String name, String collegeId) async {
    var url = Uri.parse(Database.departmentAdd);
    var data =
        jsonEncode(<String, String>{"collegeId": collegeId, "name": name});
    var response = await http.post(url, body: data);
    return response.body;
  }

  static Future deleteDepartment(int departmentId) async {
    var url = Uri.parse(Database.departmentDelete);
    var data = jsonEncode(<String, int>{"id": departmentId});
    var response = await http.post(url, body: data);
    return response.body;
  }

  static Future updateDepartment(
      int departmentId, String departmentName, String collegeId) async {
    var url = Uri.parse(Database.departmentUpdate);
    var data = jsonEncode(<String, String>{
      "id": departmentId.toString(),
      "collegeId": collegeId,
      "name": departmentName
    });
    var response = await http.post(url, body: data);
    return response.body;
  }
}
