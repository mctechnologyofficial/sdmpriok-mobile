// To parse this JSON data, do
//
//     final responseGetSlider = responseGetSliderFromJson(jsonString);

import 'dart:convert';

List<ResponseGetSlider> responseGetSliderFromJson(String str) => List<ResponseGetSlider>.from(json.decode(str).map((x) => ResponseGetSlider.fromJson(x)));

String responseGetSliderToJson(List<ResponseGetSlider> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ResponseGetSlider {
  ResponseGetSlider({
    required this.id,
    required this.type,
    required this.row,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String type;
  String row;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  factory ResponseGetSlider.fromJson(Map<String, dynamic> json) => ResponseGetSlider(
    id: json["id"],
    type: json["type"],
    row: json["row"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "row": row,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
