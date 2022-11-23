import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sdm_priok/models/responses/response_detail_employee.dart';
import 'package:sdm_priok/models/responses/response_employee.dart';

import '../helpers/data_helper.dart';

class EmployeeProvider extends ChangeNotifier {
  List<ResponseEmployee> _data = [];
  List<ResponseEmployee> get dataEmployee => _data;

  Future<List<ResponseEmployee>> getEmployee() async {
    final url = 'https://humancapitalpriokpomu.com/api/employee/';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print("RespGetEmployee : " + response.body);
      final result = json.decode(response.body)['data'].cast<Map<String, dynamic>>();
      _data = result.map<ResponseEmployee>((json) => ResponseEmployee.fromJson(json)).toList();
      return _data;
    } else {
      throw Exception();
    }
  }

  Future<ResponseEmployee> detailEmployee(String hash) async {
    return _data.firstWhere((i) => i.hash == hash);
  }
}