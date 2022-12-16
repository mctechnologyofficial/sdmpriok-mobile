import 'package:meta/meta.dart';
import 'dart:convert';

List<ResponseGetSubCategory> responseGetSubCategoryFromJson(String str) => List<ResponseGetSubCategory>.from(json.decode(str).map((x) => ResponseGetSubCategory.fromJson(x)));

String responseGetSubCategoryToJson(List<ResponseGetSubCategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ResponseGetSubCategory {
  ResponseGetSubCategory({
    required this.subCategory,
  });

  String subCategory;

  factory ResponseGetSubCategory.fromJson(Map<String, dynamic> json) => ResponseGetSubCategory(
    subCategory: json["sub_category"],
  );

  Map<String, dynamic> toJson() => {
    "sub_category": subCategory,
  };
}
