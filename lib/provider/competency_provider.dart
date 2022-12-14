import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sdm_priok/models/responses/response_get_competency.dart';

class CompetencyProvider extends ChangeNotifier {
  List<ResponseGetCompetency> _data = [];

  List<ResponseGetCompetency> get dataCompetencys => _data;

  Future<List<ResponseGetCompetency>> getCompetencys() async {
    final url = 'https://humancapitalpriokpomu.com/api/competency-op/';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print("RespGetCompetencys : " + response.body);
      final result =
          json.decode(response.body)['data'].cast<Map<String, dynamic>>();
      _data = result
          .map<ResponseGetCompetency>((json) => ResponseGetCompetency.fromJson(json))
          .toList();
      return _data;
    } else {
      throw Exception();
    }
  }
}
