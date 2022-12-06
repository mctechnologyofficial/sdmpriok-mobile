// To parse this JSON data, do
//
//     final responseTeam = responseTeamFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ResponseTeam> responseTeamFromJson(String str) => List<ResponseTeam>.from(json.decode(str).map((x) => ResponseTeam.fromJson(x)));

String responseTeamToJson(List<ResponseTeam> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ResponseTeam {
  ResponseTeam({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  factory ResponseTeam.fromJson(Map<String, dynamic> json) => ResponseTeam(
    id: json["id"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
