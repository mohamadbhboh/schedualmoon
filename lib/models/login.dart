// To parse this JSON data, do
//
//     final employeeLogin = employeeLoginFromJson(jsonString);

import 'dart:convert';

EmployeeLogin employeeLoginFromJson(String str) => EmployeeLogin.fromJson(json.decode(str));

String employeeLoginToJson(EmployeeLogin data) => json.encode(data.toJson());

class EmployeeLogin {
    EmployeeLogin({
       required this.departmentId,
       required this.password,
    });

    String departmentId;
    String password;

    factory EmployeeLogin.fromJson(Map<String, dynamic> json) => EmployeeLogin(
        departmentId: json["departmentId"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "departmentId": departmentId,
        "password": password,
    };
}
