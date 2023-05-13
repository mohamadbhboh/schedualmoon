import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:schedualmoon/models/permession.dart';
import 'package:schedualmoon/shared/database_url.dart';

class PermessionRepository {
  static var client = http.Client();
  static Future getPermessions() async {
    var url = Uri.parse(Database.permessionRead);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var jsonString = utf8.decode(response.bodyBytes);
      return permessionFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future grantPermssion(String employeeId, String permessionId) async {
    var url = Uri.parse(Database.grantPermession);
    var data = jsonEncode(<String, String>{
      'employeeId': employeeId,
      'permessionId': permessionId
    });
    var response = await http.post(url, body: data);
    return response.body;
  }

  static Future revokePermession(String employeeId, String permessionId) async {
    var url = Uri.parse(Database.revokePermession);
    var data = jsonEncode(<String, String>{
      'employeeId': employeeId,
      'permessionId': permessionId
    });
    var response = await http.post(url, body: data);
    return response.body;
  }
}
