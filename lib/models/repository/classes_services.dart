import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:schedualmoon/models/classes.dart';
import 'package:schedualmoon/models/courses/courses.dart';
import 'package:schedualmoon/models/department_teaching_matrix.dart';
import 'package:schedualmoon/models/teach_hour.dart';
import 'package:schedualmoon/models/teaching_matrix_menu_item.dart';
import 'package:schedualmoon/shared/database_url.dart';

class ClassRepository {
  static var client = http.Client();
  static Future getClasses(String departmentId, String semesterId) async {
    var url = Uri.parse(Database.classesRead);
    var data = jsonEncode(<String, String>{
      "departmentId": departmentId,
      "semesterId": semesterId
    });
    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      var jsonString = utf8.decode(response.bodyBytes);
      return classesFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future readCoursesSpecificDepartment(String departmentId) async {
    var url = Uri.parse(Database.readCoursesSpecificDepartment);
    var data = jsonEncode(<String, String>{"departmentId": departmentId});
    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      var jsonString = utf8.decode(response.bodyBytes);
      return coursesFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future readTeachingMatrix(String departmentId) async {
    var url = Uri.parse(Database.deptTeachingMatrixRead);
    var data = jsonEncode(<String, String>{"departmentId": departmentId});
    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      var jsonString = utf8.decode(response.bodyBytes);
      return departmentTeachingMatrixFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future getDepartmentEmployee(String departmentId) async {
    var url = Uri.parse(Database.deptEmployees);
    var data = jsonEncode(<String, String>{"departmentId": departmentId});
    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      var jsonString = utf8.decode(response.bodyBytes);
      return teachingMatrixMenuItemFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future getTeachHour(String departmentId) async {
    var url = Uri.parse(Database.teacherHour);
    var data = jsonEncode(<String, String>{"departmentId": departmentId});
    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      var jsonString = utf8.decode(response.bodyBytes);
      return teachHourFromJson(jsonString);
    } else {
      return null;
    }
  }
}
