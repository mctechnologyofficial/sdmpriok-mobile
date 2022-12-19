import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sdm_priok/models/responses/response_organization.dart';
import 'package:sdm_priok/models/responses/response_organization_member.dart';
import 'package:sdm_priok/models/responses/response_team.dart';

class OrganizationProvider extends ChangeNotifier {
  List<ResponseOrganization> _data = [];

  List<ResponseOrganization> get dataOrganization => _data;

  List<ResponseOrganizationMember> _dataOrganizationMember = [];

  List<ResponseOrganizationMember> get dataOrganizationMember =>
      _dataOrganizationMember;

  Future<List<ResponseOrganization>> getOrganization() async {
    final url = 'https://humancapitalpriokpomu.com/api/organization/';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print("RespGetOrganization : " + response.body);
      final result =
          json.decode(response.body)['data'].cast<Map<String, dynamic>>();
      _data = result
          .map<ResponseOrganization>(
              (json) => ResponseOrganization.fromJson(json))
          .toList();
      return _data;
    } else {
      throw Exception();
    }
  }

  Future<List<ResponseOrganizationMember>> getOrganizationMember(int id) async {
    final endpointUrl = 'https://humancapitalpriokpomu.com/api/organization/getteam';
    final uri = Uri.parse(endpointUrl).replace(queryParameters: {
      'id': id.toString(),
    });
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print("RespGetOrganizationMember : " + response.body);
      final result =
          json.decode(response.body)['data'].cast<Map<String, dynamic>>();
      _dataOrganizationMember = result
          .map<ResponseOrganizationMember>(
              (json) => ResponseOrganizationMember.fromJson(json))
          .toList();
      return _dataOrganizationMember;
    } else {
      throw Exception();
    }
  }

// Future<bool> addTeam(String name) async {
//   var endpointUrl = 'https://humancapitalpriokpomu.com/api/team/store';
//   final uri = Uri.parse(endpointUrl).replace(queryParameters: {
//     'name': name,
//   });
//   final response = await http.post(uri);
//   if (response.statusCode == 200) {
//     notifyListeners();
//     return true;
//   } else {
//     return false;
//   }
// }
//
// Future<bool> updateTeam(String id, String name) async {
//   final endpointUrl = 'https://humancapitalpriokpomu.com/api/team/update/' + id;
//   final uri = Uri.parse(endpointUrl).replace(queryParameters: {
//     'name': name,
//   });
//   final response = await http.post(uri);
//   if (response.statusCode == 200) {
//     notifyListeners();
//     return true;
//   }
//   return false;
// }
//
// Future<ResponseTeam> detailTeam(int id) async {
//   return _data.firstWhere((i) => i.id == id);
// }
//
// // Future<void> deleteTeam(int id) async {
// //   final url = 'https://humancapitalpriokpomu.com/api/team/delete/' + id.toString();
// //   await http.post(url);
// //   notifyListeners();
// // }
//
// Future<bool> deleteTeam(int id) async {
//   final url = 'https://humancapitalpriokpomu.com/api/team/delete/' + id.toString();
//   final response = await http.post(Uri.parse(url));
//   print("RespDeleteTeam : " + response.body);
//   if (response.statusCode == 200) {
//     notifyListeners();
//     return true;
//   } else {
//     return false;
//   }
// }

}
