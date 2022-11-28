// To parse this JSON data, do
//
//     final responseAddRole = responseAddRoleFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ResponseAddRole responseAddRoleFromJson(String str) => ResponseAddRole.fromJson(json.decode(str));

String responseAddRoleToJson(ResponseAddRole data) => json.encode(data.toJson());

class ResponseAddRole {
  ResponseAddRole({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  int code;
  bool status;
  String message;
  Data data;

  factory ResponseAddRole.fromJson(Map<String, dynamic> json) => ResponseAddRole(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.guardName,
    required this.name,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  String guardName;
  String name;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    guardName: json["guard_name"],
    name: json["name"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "guard_name": guardName,
    "name": name,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}
