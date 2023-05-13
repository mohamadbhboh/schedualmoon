import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:schedualmoon/shared/database_url.dart';
import 'package:schedualmoon/models/ranks.dart';

class RankRepository {
  static var client = http.Client();

  static Future getRanks() async {
    var url = Uri.parse(Database.rankRead);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var jsonString = utf8.decode(response.bodyBytes);
      return ranksFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future deleteRank(String id) async {
    var url = Uri.parse(Database.deleteRank);
    var data = jsonEncode(<String, String>{"id": id});
    var responce = await http.post(url, body: data);
    print(responce.body);
    return responce.body;
  }

  static Future editRank(String id, String name, String hourNumber) async {
    var url = Uri.parse(Database.updateRank);
    var data = jsonEncode(
        <String, String>{"id": id, "name": name, "hourNumber": hourNumber});
    var responce = await http.post(url, body: data);
    return responce.body;
  }

  static Future addRank(String name, String hourNumber) async {
    var url = Uri.parse(Database.createRank);
    var data =
        jsonEncode(<String, String>{"name": name, "hourNumber": hourNumber});
    var responce = await http.post(url, body: data);
    return responce.body;
  }
}
