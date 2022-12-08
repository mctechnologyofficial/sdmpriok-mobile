import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sdm_priok/models/responses/response_detail_employee.dart';
import 'package:sdm_priok/models/responses/response_employee.dart';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;

import '../helpers/data_helper.dart';

class EmployeeProvider extends ChangeNotifier {
  List<ResponseEmployee> _data = [];

  List<ResponseEmployee> get dataEmployee => _data;

  Future<List<ResponseEmployee>> getEmployee() async {
    final url = 'https://humancapitalpriokpomu.com/api/employee/';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print("RespGetEmployee : " + response.body);
      final result =
          json.decode(response.body)['data'].cast<Map<String, dynamic>>();
      _data = result
          .map<ResponseEmployee>((json) => ResponseEmployee.fromJson(json))
          .toList();
      return _data;
    } else {
      throw Exception();
    }
  }

  Future<ResponseEmployee> detailEmployee(String hash) async {
    return _data.firstWhere((i) => i.hash == hash);
  }

  // Future<void> deleteEmployee(String hash) async {
  //   final url = 'https://humancapitalpriokpomu.com/api/employee/delete/' + hash;
  //   final response = await http.get(Uri.parse(url));
  //   print("RespDeleteEmployee : " + response.body);
  //   if (response.statusCode == 200) {
  //     notifyListeners();
  //     print("RespDeleteEmployee : " + response.body);
  //   } else {
  //
  //   }
  // }

  Future<bool> addEmployee(String nip, String name, String phone, String email, String password, String team_id, String role_id, File image) async {
    try {
      var stream =
          http.ByteStream(DelegatingStream.typed(image.openRead()));
      var length = await image.length();
      var uri = Uri.parse("https://humancapitalpriokpomu.com/api/employee/store");
      final request = http.MultipartRequest("POST", uri);
      request.fields['nip'] = nip;
      request.fields['name'] = name;
      request.fields['phone'] = phone;
      request.fields['email'] = email;
      request.fields['password'] = password;
      request.fields['team_id'] = team_id;
      request.fields['role_id'] = role_id;
      request.files.add(http.MultipartFile("image", stream, length,
          filename: path.basename(image.path)));
      var response = await request.send();
      if (response.statusCode == 200) {
      notifyListeners();
      return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("Error $e");
      return false;
    }
  }

  Future<bool> updateEmployeeWithoutImage(String hash, String nip, String name, String phone, String email, String team_id, String role_id) async {
    try {
      // var stream =
          // http.ByteStream(DelegatingStream.typed(image.openRead()));
      // var length = await image.length();
      var uri = Uri.parse("https://humancapitalpriokpomu.com/api/employee/update/"+hash);
      final request = http.MultipartRequest("POST", uri);
      request.fields['nip'] = nip;
      request.fields['name'] = name;
      request.fields['phone'] = phone;
      request.fields['email'] = email;
      request.fields['team_id'] = team_id;
      request.fields['role_id'] = role_id;
      // request.files.add(http.MultipartFile("image", stream, length,
          // filename: path.basename(image.path)));
      var response = await request.send();
      // final respStr = await response.stream.bytesToString();
      if (response.statusCode == 200) {
      // print(respStr);
      notifyListeners();
      return true;
      } else {
        // print(respStr);
        return false;
      }
    } catch (e) {
      debugPrint("Error $e");
      return false;
    }
  }

  Future<bool> updateEmployee(String hash, String nip, String name, String phone, String email, String team_id, String role_id, File image) async {
    try {
      var stream =
          http.ByteStream(DelegatingStream.typed(image.openRead()));
      var length = await image.length();
      var uri = Uri.parse("https://humancapitalpriokpomu.com/api/employee/update/"+hash);
      final request = http.MultipartRequest("POST", uri);
      request.fields['nip'] = nip;
      request.fields['name'] = name;
      request.fields['phone'] = phone;
      request.fields['email'] = email;
      request.fields['team_id'] = team_id;
      request.fields['role_id'] = role_id;
      request.files.add(http.MultipartFile("image", stream, length,
          filename: path.basename(image.path)));
      var response = await request.send();
      // final respStr = await response.stream.bytesToString();
      if (response.statusCode == 200) {
      notifyListeners();
      // print(respStr);
      return true;
      } else {
        // print(respStr);
        return false;
      }
    } catch (e) {
      debugPrint("Error $e");
      return false;
    }
  }

  Future<bool> deleteEmployee(String hash) async {
    final url = 'https://humancapitalpriokpomu.com/api/employee/delete/' + hash;
    final response = await http.post(Uri.parse(url));
    // ResponseAddRole responseLogin = ResponseAddRole.fromJson(jsonDecode(response.body));
    print("RespDeleteEmployee : " + response.body);
    if (response.statusCode == 200) {
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}
