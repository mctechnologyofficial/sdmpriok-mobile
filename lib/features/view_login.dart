import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sdm_priok/features/view_home.dart';
import 'package:sdm_priok/helpers/colours.dart';

class LoginPage extends StatefulWidget {
  static String TagLogin = "LoginPage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final txtTitle = Text(
      "Welcome To\nSDM Management",
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.bold,),
    );

    final imgLogo = Hero(
      tag: "Hero",
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 100,
        child: Image.asset("assets/images/ic_login.png"),
      ),
    );

    final etEmail = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final etPassword = TextFormField(
      autofocus: false,
      obscureText: true,
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
        color: colorPrimary,
        clipBehavior: Clip.antiAlias,
        child: MaterialButton(
          minWidth: 200.0,
          height: 50,
          color: colorPrimary,
          child: Text('Login', style: new TextStyle(fontSize: 16.0, color: Colors.white)),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
              return HomePage();
            }));
          },
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
    );
  }
}
