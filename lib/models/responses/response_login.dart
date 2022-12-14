// To parse this JSON data, do
//
//     final responseLogin = responseLoginFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ResponseLogin responseLoginFromJson(String str) => ResponseLogin.fromJson(json.decode(str));

String responseLoginToJson(ResponseLogin data) => json.encode(data.toJson());

class ResponseLogin {
  ResponseLogin({
    required this.code,
    required this.status,
    required this.name,
    required this.role,
    required this.image,
    required this.message,
    required this.token,
  });

  int code;
  bool status;
  String name;
  String role;
  String image;
  String message;
  String token;

  factory ResponseLogin.fromJson(Map<String, dynamic> json) => ResponseLogin(
    code: json["code"],
    status: json["status"],
    name: json["name"],
    role: json["role"],
    image: json["image"],
    message: json["message"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "name": name,
    "role": role,
    "image": image,
    "message": message,
    "token": token,
  };
}
