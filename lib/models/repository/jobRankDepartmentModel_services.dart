import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:schedualmoon/models/jobRankDepartmentmodel.dart';
import 'package:schedualmoon/shared/database_url.dart';

class JobRankDepartmentRepository {
  static var client = http.Client();
  static Future getjobRankDepartment() async {
    var url = Uri.parse(Database.jobRankDepartmentRead);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var jsonString = utf8.decode(response.bodyBytes);
      return jobRankDepartmentModelFromJson(jsonString);
    } else {
      return null;
    }
  }
}
