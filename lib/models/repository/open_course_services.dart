import 'package:http/http.dart' as http;
import 'package:schedualmoon/shared/database_url.dart';

class OpenCourseRepository {
  static Future openCourse(String jsonCategory) async {
    var url = Uri.parse(Database.openCourse);
    var responce = await http.post(url, body: jsonCategory);
    return responce.body;
  }
}
