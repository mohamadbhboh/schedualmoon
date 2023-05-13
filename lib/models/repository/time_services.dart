import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:schedualmoon/models/time.dart';
import 'package:schedualmoon/shared/database_url.dart';

class TimeRepository {
  static var client = http.Client();
  static Future getTimes() async {
    var url = Uri.parse(Database.timeRead);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var jsonString = utf8.decode(response.bodyBytes);
      return timeClassesFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future deleteTime(String id) async {
    var url = Uri.parse(Database.timeDelete);
    var data = jsonEncode(<String, String>{"id": id});
    var response = await http.post(url, body: data);
    return response.body;
  }

  static Future createTime(String hour, String time) async {
    var url = Uri.parse(Database.createTime);
    var data = jsonEncode(<String, String>{"time": time, "hour": hour});
    var response = await http.post(url, body: data);
    return response.body;
  }

  static Future updateTime(String time, String id) async {
    var url = Uri.parse(Database.updateTime);
    var data = jsonEncode(<String, String>{"time": time, "id": id});
    var response = await http.post(url, body: data);
    return response.body;
  }
}
