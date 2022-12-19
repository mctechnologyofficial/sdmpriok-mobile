import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sdm_priok/models/responses/response_get_category.dart';
import 'package:sdm_priok/models/responses/response_get_competency.dart';
import 'package:sdm_priok/models/responses/response_get_sub_category.dart';

class CompetencyProvider extends ChangeNotifier {
  List<ResponseGetCompetency> _data = [];

  List<ResponseGetCompetency> get dataCompetencys => _data;
  List<ResponseGetCategory> listCategory = [];

  List<ResponseGetCategory> get dataCategory => listCategory;
  List<ResponseGetSubCategory> listSubCategory = [];

  List<ResponseGetSubCategory> get dataSubCategory => listSubCategory;

  Future<List<ResponseGetCompetency>> getCompetencys() async {
    final url = 'https://humancapitalpriokpomu.com/api/competency-op/';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print("RespGetCompetencys : " + response.body);
      final result =
          json.decode(response.body)['data'].cast<Map<String, dynamic>>();
      _data = result
          .map<ResponseGetCompetency>(
              (json) => ResponseGetCompetency.fromJson(json))
          .toList();
      return _data;
    } else {
      throw Exception();
    }
  }

  Future<List<ResponseGetCategory>> getCategoryCompetencys(
      String category) async {
    var endpointUrl =
        'https://humancapitalpriokpomu.com/api/competency-op/getcategory';
    final uri = Uri.parse(endpointUrl).replace(queryParameters: {
      'competency': category,
    });
    final response = await http.get(uri);
    print("ResponseCode : " + response.statusCode.toString());
    if (response.statusCode == 200) {
      print("RespGetCategoryCompetencys : " + response.body);
      final result = json
          .decode(response.body)['data']['data']
          .cast<Map<String, dynamic>>();
      listCategory = result
          .map<ResponseGetCategory>(
              (json) => ResponseGetCategory.fromJson(json))
          .toList();
      return listCategory;
    } else {
      throw Exception();
    }
  }

  Future<List<ResponseGetSubCategory>> getSubCategoryCompetencys(String subcategory) async {
    var endpointUrl = 'https://humancapitalpriokpomu.com/api/competency-op/getsubcategory';
    final uri = Uri.parse(endpointUrl).replace(queryParameters: {
      'category': subcategory,
    });
    final response = await http.get(uri);
    print("ResponseCode : " + response.statusCode.toString());
    if (response.statusCode == 200) {
      print("RespGetSubCategoryCompetencys : " + response.body);
      final result = json.decode(response.body)['data']['data'].cast<Map<String, dynamic>>();
      listSubCategory = result.map<ResponseGetSubCategory>((json) => ResponseGetSubCategory.fromJson(json)).toList();
      return listSubCategory;
    } else {
      throw Exception();
    }
  }
}
