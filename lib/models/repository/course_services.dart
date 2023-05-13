import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:schedualmoon/models/courses/base_courses.dart';
import 'package:schedualmoon/shared/database_url.dart';
import 'package:schedualmoon/models/courses/courses.dart';

class CoursesRepository {
  static var client = http.Client();
  static Future getCourses() async {
    var url = Uri.parse(Database.courseRead);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var jsonString = utf8.decode(response.bodyBytes);
      return coursesFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future deleteCourse(String id) async {
    var url = Uri.parse(Database.courseDelete);
    var data = jsonEncode(<String, String>{"id": id});
    var response = await http.post(url, body: data);
    return response.body;
  }

  static Future updateCourse(String oldId, Courses _newCourse) async {
    var url = Uri.parse(Database.CourseEdit);
    var data = jsonEncode(<String, String>{
      'id': _newCourse.id,
      'departmentId': _newCourse.departmentId.toString(),
      'arabicName': _newCourse.arabicName,
      'englishName': _newCourse.englishName,
      'totalHour': _newCourse.totalHour.toString(),
      'theoriticalHour': _newCourse.theoriticalHour.toString(),
      'labHour': _newCourse.labHour.toString(),
      'year': _newCourse.year.toString(),
      'semester': _newCourse.semester.toString(),
      'oldId': oldId
    });
    var response = await http.post(url, body: data);
    return response.body;
  }

  static Future addCourse(Courses _newCourse) async {
    var url = Uri.parse(Database.CourseAdd);
    var data = jsonEncode(<String, String>{
      'id': _newCourse.id,
      'departmentId': _newCourse.departmentId.toString(),
      'arabicName': _newCourse.arabicName,
      'englishName': _newCourse.englishName,
      'totalHour': _newCourse.totalHour.toString(),
      'theoriticalHour': _newCourse.theoriticalHour.toString(),
      'labHour': _newCourse.labHour.toString(),
      'year': _newCourse.year.toString(),
      'semester': _newCourse.semester.toString(),
    });
    var response = await http.post(url, body: data);
    return response.body;
  }

  static Future getGraduateCourse(String departmentId) async {
    var url = Uri.parse(Database.graduateCourseRead);
    var data = jsonEncode(<String, String>{"departmentId": departmentId});
    var response = await http.post(url, body: data);
    var jsonString = utf8.decode(response.bodyBytes);
    return baseCoursesFromJson(jsonString);
  }
}
