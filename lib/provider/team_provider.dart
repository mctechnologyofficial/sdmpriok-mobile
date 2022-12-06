import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sdm_priok/models/responses/response_team.dart';

class TeamProvider extends ChangeNotifier {
  List<ResponseTeam> _data = [];

  List<ResponseTeam> get dataTeams => _data;

  Future<List<ResponseTeam>> getTeams() async {
    final url = 'https://humancapitalpriokpomu.com/api/team/';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print("RespGetTeams : " + response.body);
      final result = json.decode(response.body)['data'].cast<Map<String, dynamic>>();
      _data = result.map<ResponseTeam>((json) => ResponseTeam.fromJson(json)).toList();
      return _data;
    } else {
      throw Exception();
    }
  }

  Future<bool> addTeam(String name) async {
    var endpointUrl = 'https://humancapitalpriokpomu.com/api/team/store';
    final uri = Uri.parse(endpointUrl).replace(queryParameters: {
      'name': name,
    });
    final response = await http.post(uri);
    if (response.statusCode == 200) {
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateTeam(String id, String name) async {
    final endpointUrl = 'https://humancapitalpriokpomu.com/api/team/update/' + id;
    final uri = Uri.parse(endpointUrl).replace(queryParameters: {
      'name': name,
    });
    final response = await http.post(uri);
    if (response.statusCode == 200) {
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<ResponseTeam> detailTeam(int id) async {
    return _data.firstWhere((i) => i.id == id);
  }

  // Future<void> deleteTeam(int id) async {
  //   final url = 'https://humancapitalpriokpomu.com/api/team/delete/' + id.toString();
  //   await http.post(url);
  //   notifyListeners();
  // }

  Future<bool> deleteTeam(int id) async {
    final url = 'https://humancapitalpriokpomu.com/api/team/delete/' + id.toString();
    final response = await http.post(Uri.parse(url));
    print("RespDeleteTeam : " + response.body);
    if (response.statusCode == 200) {
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

}
