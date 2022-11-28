import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sdm_priok/models/responses/response_role.dart';
import 'package:sdm_priok/models/responses/response_role_added.dart';

class RoleProvider extends ChangeNotifier {
  List<ResponseGetRoles> _data = [];

  List<ResponseGetRoles> get dataRoles => _data;

  Future<List<ResponseGetRoles>> getRoles() async {
    final url = 'https://humancapitalpriokpomu.com/api/role/';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print("RespGetRoles : " + response.body);
      final result =
          json.decode(response.body)['data'].cast<Map<String, dynamic>>();
      _data = result
          .map<ResponseGetRoles>((json) => ResponseGetRoles.fromJson(json))
          .toList();
      return _data;
    } else {
      throw Exception();
    }
  }

  Future<bool> addRole(String name, String guard_name) async {
    var endpointUrl = 'https://humancapitalpriokpomu.com/api/role/store';
    final uri = Uri.parse(endpointUrl).replace(queryParameters: {
      'name': name,
      'guard_name': guard_name,
    });
    final response = await http.post(uri);
    // ResponseAddRole responseLogin = ResponseAddRole.fromJson(jsonDecode(response.body));

    if (response.statusCode == 200) {
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateRole(String id, String name, String guard_name) async {
    final endpointUrl = 'https://humancapitalpriokpomu.com/api/role/update/' + id;

    final uri = Uri.parse(endpointUrl).replace(queryParameters: {
      'name': name,
      'guard_name': guard_name,
    });
    final response = await http.post(uri);
    if (response.statusCode == 200) {
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<ResponseGetRoles> detailRole(int id) async {
    return _data.firstWhere((i) => i.id == id);
  }

}
