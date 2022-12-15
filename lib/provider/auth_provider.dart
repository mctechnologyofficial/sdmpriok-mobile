import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sdm_priok/models/responses/response_login.dart';

import '../helpers/data_helper.dart';

class AuthProvider extends ChangeNotifier {
  DataHelper dataHelper = new DataHelper();

  Future<bool> postRegister(String name, String email, String password,
      String phone, String team) async {
    final url = 'https://humancapitalpriokpomu.com/api/auth/register';
    final response = await http.post(url, body: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'team_id': team
    });

    final result = json.decode(response.body);
    if (response.statusCode == 200 && result['status'] == 'success') {
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> postLogin(String email, String password) async {
    var endpointUrl = 'https://humancapitalpriokpomu.com/api/auth/login';
    final uri = Uri.parse(endpointUrl).replace(queryParameters: {
      'email': email,
      'password': password,
    });
    final response = await http.post(uri);
    print("RespLogin : " + response.body);
    ResponseLogin responseLogin = ResponseLogin.fromJson(jsonDecode(response.body));

    if (response.statusCode == 200) {
      notifyListeners();
      String role = responseLogin.role.toLowerCase();
      print("Role : " + role);
      dataHelper.setIsLoggedIn(true);
      dataHelper.setLoginName(responseLogin.name);
      dataHelper.setLoginPict(responseLogin.image);
      if (role == "admin") {
        dataHelper.setLoginRole(dataHelper.Role_Admin);
      } else if (role == "supervisor operator") {
        dataHelper.setLoginRole(dataHelper.Role_Supervisor);
      } else if (role == "supervisor senior") {
        print("SPVSenior : " + "True");
        dataHelper.setLoginRole(dataHelper.Role_Supervisor);
      } else if (role == "supervisor") {
        dataHelper.setLoginRole(dataHelper.Role_Supervisor);
      } else if (role == "senior operator") {
        dataHelper.setLoginRole(dataHelper.Role_Operator);
      } else if (role == "ahli muda operator") {
        dataHelper.setLoginRole(dataHelper.Role_Operator);
      } else if (role == "operator senior control room") {
        dataHelper.setLoginRole(dataHelper.Role_Operator);
      } else if (role == "operator gt rsg") {
        dataHelper.setLoginRole(dataHelper.Role_Operator);
      }
      return true;
    } else {
      return false;
    }
  }
}
