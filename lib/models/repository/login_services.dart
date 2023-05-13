import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:schedualmoon/models/login.dart';
import 'package:schedualmoon/shared/database_url.dart';

class LoginRepository {
  static var client = http.Client();
  static Future getLoginemployee(employeeId) async {
    var url = Uri.parse(Database.employeeLoginRead);
    var data = jsonEncode(<String, String>{
      'employeeId': employeeId,
    });
    var responce = await http.post(url, body: data);
    var jsonString = responce.body;
    return employeeLoginFromJson(jsonString);
  }
}
