import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sdm_priok/features/auth/view_register.dart';
import 'package:sdm_priok/features/homes/view_home_admin.dart';
import 'package:sdm_priok/features/homes/view_home_supervisor.dart';
import 'package:sdm_priok/helpers/colours.dart';
import 'package:sdm_priok/helpers/data_helper.dart';
import 'package:sdm_priok/provider/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../homes/view_home_operator.dart';

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
  bool _isLoading = false;

  void login(BuildContext context) {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      EasyLoading.showError('Please fill in all data !');
    } else {
      if (!_isLoading) {
        setState(() {
          _isLoading = true;
        });
        EasyLoading.show(status: 'Loading...');
        Provider.of<AuthProvider>(context, listen: false).postLogin(emailController.text, passwordController.text).then((res) {
          if (res) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess('Welcome !');
            setState(() {
              _isLoading = false;
            });
            switchPage();
          } else {
            EasyLoading.dismiss();
            EasyLoading.showError('Incorrect Email Or Password !');
            setState(() {
              _isLoading = false;
            });
          }
        });
      }
    }
  }

  void switchPage(){
    // Future<String?> loginRole = dataHelper.getLoginRole();
    // if (dataHelper.getLoginRole() == dataHelper.Role_Admin) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeAdminPage()), (route) => false);
    // } else if (dataHelper.getLoginRole() == dataHelper.Role_Supervisor) {
    //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeSupervisorPage()), (route) => false);
    // } else if (dataHelper.getLoginRole() == dataHelper.Role_Operator) {
    //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeOperatorPage()), (route) => false);
    // } else {
    //   EasyLoading.showInfo('Your account has a problem, please contact the call center !');
    // }
  }

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

    final btnRegister = GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => RegisterPage()));
      },
      child: Text(
        "Don't have an account ?, Sign up here !",
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
            fontSize: 14, fontWeight: FontWeight.w300, color: ColorPrimary),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                btnRegister,
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        color: ColorWhitePrimary,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Material(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 5,
            color: ColorPrimary,
            clipBehavior: Clip.antiAlias,
            child: MaterialButton(
              minWidth: 200.0,
              height: 50,
              color: ColorPrimary,
              child: Text('Sign In',
                  style: TextStyle(fontSize: 16.0, color: Colors.white)),
              onPressed: () {
                login(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}
