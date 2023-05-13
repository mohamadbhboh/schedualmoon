// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:csv/csv.dart';

class ExportCsv {
  final List data;
  ExportCsv({required this.data});

  // ignore: deprecated_member_use
  List<List<dynamic>> rows = <List<dynamic>>[];
  downloadData() {
    for (int i = 0; i < data.length; i++) {
      List<dynamic> row = [];
      row.add(data[i].courseId);
      row.add(data[i].courseName);
      row.add(data[i].theory);
      row.add(data[i].lab);
      row.add(data[i].studentCount);
      row.add(data[i].year);
      row.add(data[i].semester);
      row.add(data[i].teacher);
      row.add(data[i].time);
      row.add(data[i].day);
      rows.add(row);
    }

    String csv = const ListToCsvConverter().convert(rows);
    AnchorElement(href: "data:text/plain;charset=utf-8,$csv")
      ..setAttribute("download", "Semester_program_IT.csv")
      ..click();
  }
}
