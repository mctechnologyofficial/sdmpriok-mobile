import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sdm_priok/features/auth/view_login.dart';
import 'package:sdm_priok/features/homes/view_home_admin.dart';
import 'package:sdm_priok/features/homes/view_home_operator.dart';
import 'package:sdm_priok/features/homes/view_home_supervisor.dart';
import 'package:sdm_priok/helpers/colours.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/data_helper.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  State<SplashScreenPage> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenPage> {
  DataHelper dataHelper = new DataHelper();
  SharedPreferences? sharedPref;
  String? loginEmail = "";

  @override
  void initState() {
    super.initState();
    initializePreference().whenComplete(() {
      bool isLoggedIn = this.sharedPref?.getBool("IsLoggedIn") ?? false;
      loginEmail = this.sharedPref?.getString("Name");
      if (isLoggedIn == true) {
        startHomeScreen();
      } else {
        startSplashScreen();
      }
    });
  }

  Future<void> initializePreference() async {
    this.sharedPref = await SharedPreferences.getInstance();
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return LoginPage();
      }));
    });
  }

  startHomeScreen() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        if (loginEmail == "admin@gmail.com") {
          return HomeAdminPage();
        } else if (loginEmail == "supervisor@gmail.com") {
          return HomeSupervisorPage();
        } else if (loginEmail == "operator@gmail.com") {
          return HomeOperatorPage();
        } else {
          return HomeAdminPage();
        }
        // if (dataHelper.getLoginRole() == dataHelper.Role_Admin) {
        //   return HomeAdminPage();
        // } else if (dataHelper.getLoginRole() == dataHelper.Role_Supervisor) {
        //   return HomeSupervisorPage();
        // } else if (dataHelper.getLoginRole() == dataHelper.Role_Operator) {
        //   return HomeOperatorPage();
        // } else {
        //   return LoginPage();
        // }
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPrimary,
      body: Center(
          child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          "assets/icons/ic_pln.png",
          height: 150,
          width: 150,
        ),
      )),
    );
  }
}
