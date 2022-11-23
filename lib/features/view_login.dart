import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sdm_priok/features/homes/view_home_admin.dart';
import 'package:sdm_priok/features/homes/view_home_supervisor.dart';
import 'package:sdm_priok/helpers/colours.dart';
import 'package:sdm_priok/helpers/data_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homes/view_home_operator.dart';

class LoginPage extends StatefulWidget {
  static String TagLogin = "LoginPage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  DataHelper dataHelper = new DataHelper();
  String? loginEmail = "";

  @override
  Widget build(BuildContext context) {
    final txtTitle = Text(
      "Welcome To\nSDM Management",
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );

    final imgLogo = Hero(
      tag: "Hero",
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 100,
        child: Image.asset("assets/icons/ic_login.png"),
      ),
    );

    final etEmail = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: emailController,
      decoration: InputDecoration(
        hintText: 'Email',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final etPassword = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordController,
      decoration: InputDecoration(
        hintText: 'Password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final btnLogin = Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 2,
        color: ColorPrimary,
        clipBehavior: Clip.antiAlias,
        child: MaterialButton(
          minWidth: 200.0,
          height: 50,
          color: ColorPrimary,
          child: Text('Login',
              style: new TextStyle(fontSize: 16.0, color: Colors.white)),
          onPressed: () {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (_) {
              loginEmail = emailController.text.toString();
              dataHelper.setIsLoggedIn(true);
              dataHelper.setLoginName(loginEmail!);
              if (loginEmail == "admin@gmail.com") {
                return HomeAdminPage();
              } else if (loginEmail == "supervisor@gmail.com") {
                return HomeSupervisorPage();
              } else if (loginEmail == "operator@gmail.com") {
                return HomeOperatorPage();
              } else {
                return HomeOperatorPage();
              }
            }));
          },
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(20),
                children: <Widget>[
                  txtTitle,
                  imgLogo,
                  SizedBox(
                    height: 40,
                  ),
                  etEmail,
                  SizedBox(
                    height: 10,
                  ),
                  etPassword,
                  SizedBox(
                    height: 10,
                  ),
                  btnLogin
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
