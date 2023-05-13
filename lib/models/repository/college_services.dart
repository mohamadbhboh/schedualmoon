import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:schedualmoon/models/colleges.dart';
import 'package:schedualmoon/shared/database_url.dart';

class CollegesRepository {
  static var client = http.Client();
  static Future getColleges() async {
    var url = Uri.parse(Database.collegeRead);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var jsonString = utf8.decode(response.bodyBytes);
      return collegesFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future deleteColleges(String id) async {
    var url = Uri.parse(Database.collegeDelete);
    var data = jsonEncode(<String, String>{
      'id': id,
    });
    var response = await http.post(url, body: data);
    return response.body;
  }

  static Future addColege(String name) async {
    var url = Uri.parse(Database.addColege);
    var data = jsonEncode(<String, String>{
      'name': name,
    });
    var responce = await http.post(url, body: data);
    return responce.body;
  }

  static Future editColege(String id, String name) async {
    var url = Uri.parse(Database.ColegeEdit);
    var data = jsonEncode(<String, String>{'id': id, 'name': name});
    var response = await http.post(url, body: data);
    return response.body;
  }
}
