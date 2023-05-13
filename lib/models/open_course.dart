import 'dart:convert';

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Map<String, dynamic> toJson() => {
        "departmentId": departmentId,
        "courseId": courseId,
        "semesterId": semesterId,
        "ClassCategory": List<dynamic>.from(allClasses.map((x) => x.toJson())),
      };
  Category();
  String courseId = "";
  int semesterId = 0;
  int departmentId = 0;
  List<ClassCategory> allClasses = <ClassCategory>[];
}

class ClassCategory {
  ClassCategory();
  int hourNumber = 0;
  int studentCount = 0;
  int lapOrNot = 0;
  int classNumber = 0;
  String employeeId = "";
  //this onlu using in application to specify who element that added to list for update an element
  String classCategoryId = "";

  Map<String, dynamic> toJson() => {
        "studentCount": studentCount,
        "lapOrNot": lapOrNot,
        "classNumber": classNumber,
        "employeeId": employeeId,
        "classCategoryId": classCategoryId,
        "hourNumber": hourNumber
      };
}
