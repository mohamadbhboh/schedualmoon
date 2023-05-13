import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:schedualmoon/shared/database_url.dart';

class GenticAlgorithmRepository {
  static var client = http.Client();
  static Future run(String semester, String jsonEmployeeOff,
      String departmentId, String semesterId) async {
    var url = Uri.parse(Database.runAlgorithm);
    var data = jsonEncode(<String, String>{
      "currentSemester": semester,
      "doctorOff": jsonEmployeeOff,
      "departmentId": departmentId,
      "semesterId": semesterId
    });
    var responce = await http.post(url, body: data);
    return responce.body;
  }
}
