import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sdm_priok/features/view_home.dart';
import 'package:sdm_priok/features/view_login.dart';
import 'package:sdm_priok/helpers/colours.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  State<SplashScreenPage> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenPage> {
  @override
  void initState(){
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async{
    var duration = const Duration(seconds: 2);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) {
          return LoginPage();
        })
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimary,
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            "assets/images/ic_pln.png",
            height: 150,
            width: 150,
          ),
        )
      ),
    );
  }
}
