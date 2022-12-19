import 'package:meta/meta.dart';
import 'dart:convert';

List<ResponseOrganization> responseOrganizationFromJson(String str) => List<ResponseOrganization>.from(json.decode(str).map((x) => ResponseOrganization.fromJson(x)));

String responseOrganizationToJson(List<ResponseOrganization> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ResponseOrganization {
  ResponseOrganization({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  factory ResponseOrganization.fromJson(Map<String, dynamic> json) => ResponseOrganization(
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
