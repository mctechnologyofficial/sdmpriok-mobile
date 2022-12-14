import 'dart:convert';

List<ResponseGetCompetency> responseGetCompetencyFromJson(String str) =>
    List<ResponseGetCompetency>.from(
        json.decode(str).map((x) => ResponseGetCompetency.fromJson(x)));

String responseGetCompetencyToJson(List<ResponseGetCompetency> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ResponseGetCompetency {
  ResponseGetCompetency({
    required this.id,
    required this.name,
    required this.category,
    required this.subCategory,
    required this.role,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String category;
  String subCategory;
  String role;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  factory ResponseGetCompetency.fromJson(Map<String, dynamic> json) =>
      ResponseGetCompetency(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        subCategory: json["sub_category"],
        role: json["role"],
        image: json["image"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "sub_category": subCategory,
        "role": role,
        "image": image,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
      };
}
