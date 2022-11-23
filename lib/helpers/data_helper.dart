import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class DataHelper{
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
    String? name = sharedPref?.getString("Role");
    return name;
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

  Future<String> loginName() async {
    final SharedPreferences prefs = await _prefs;
    final String name = prefs.getString('Name') ?? "";
    return name;
  }

  Future<void> clearDatas() async{
    SharedPreferences preferences  = await SharedPreferences.getInstance();
    preferences.remove("Name");
    preferences.remove("IsLoggedIn");
  }

}