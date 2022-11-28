// To parse this JSON data, do
//
//     final responseGetRoles = responseGetRolesFromJson(jsonString);

import 'dart:convert';

List<ResponseGetRoles> responseGetRolesFromJson(String str) => List<ResponseGetRoles>.from(json.decode(str).map((x) => ResponseGetRoles.fromJson(x)));

String responseGetRolesToJson(List<ResponseGetRoles> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ResponseGetRoles {
  ResponseGetRoles({
    required this.id,
    required this.name,
    required this.guardName,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String guardName;
  DateTime createdAt;
  DateTime updatedAt;

  factory ResponseGetRoles.fromJson(Map<String, dynamic> json) => ResponseGetRoles(
    id: json["id"],
    name: json["name"],
    guardName: json["guard_name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "guard_name": guardName,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
