import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class DataHelper{
  String Role_Admin = "Admin";
  String Role_Supervisor = "Supervisor";
  String Role_Operator = "Operator";
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences? sharedPref;

  Future<void> setLoginName(String name) async{
    sharedPref = await SharedPreferences.getInstance();
    sharedPref?.setString("Name", name);
  }

  Future<String?> getLoginName() async {
    sharedPref = await SharedPreferences.getInstance();
    String? name = sharedPref?.getString("Name");
    return name;
  }

  Future<void> setLoginRole(String role) async{
    sharedPref = await SharedPreferences.getInstance();
    sharedPref?.setString("Role", role);
  }

  Future<String?> getLoginRole() async {
    sharedPref = await SharedPreferences.getInstance();
    String? role = sharedPref?.getString("Role");
    return role;
  }

  Future<void> setLoginPict(String pict) async{
    sharedPref = await SharedPreferences.getInstance();
    sharedPref?.setString("Pict", pict);
  }

  Future<String?> getLoginPict() async {
    sharedPref = await SharedPreferences.getInstance();
    String? pict = sharedPref?.getString("Pict");
    return pict;
  }

  Future<void> setIsLoggedIn(bool isLoggedIn) async{
    sharedPref = await SharedPreferences.getInstance();
    sharedPref?.setBool("IsLoggedIn", isLoggedIn);
  }

  getIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? boolValue = prefs.getBool('IsLoggedIn');
    return boolValue;
  }

  Future<void> clearDatas() async{
    SharedPreferences preferences  = await SharedPreferences.getInstance();
    preferences.remove("Name");
    preferences.remove("IsLoggedIn");
  }

}