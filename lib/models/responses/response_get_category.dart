// To parse this JSON data, do
//
//     final responseGetCategory = responseGetCategoryFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ResponseGetCategory> responseGetCategoryFromJson(String str) => List<ResponseGetCategory>.from(json.decode(str).map((x) => ResponseGetCategory.fromJson(x)));

String responseGetCategoryToJson(List<ResponseGetCategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ResponseGetCategory {
  ResponseGetCategory({
    required this.category,
  });

  String category;

  factory ResponseGetCategory.fromJson(Map<String, dynamic> json) => ResponseGetCategory(
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "category": category,
  };
}
