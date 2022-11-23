import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sdm_priok/features/auth/view_login.dart';
import 'package:sdm_priok/features/homes/view_home_admin.dart';
import 'package:sdm_priok/features/homes/view_home_supervisor.dart';
import 'package:sdm_priok/helpers/colours.dart';
import 'package:sdm_priok/helpers/data_helper.dart';
import 'package:sdm_priok/provider/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../homes/view_home_operator.dart';

class RegisterPage extends StatefulWidget {
  static String TagLogin = "LoginPage";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController conPasswordController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController teamController = new TextEditingController();
  DataHelper dataHelper = new DataHelper();
  String? loginEmail = "";
  final snackbarKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;

  void register(BuildContext context) {
    if (!_isLoading) {
      // snackbarKey.currentState.showSnackBar(snackbar);
      // setState(() {
      //   _isLoading = true;
      // });
      Provider.of<AuthProvider>(context, listen: false)
          .postRegister(
              nameController.text,
              emailController.text,
              passwordController.text,
              phoneController.text,
              teamController.text)
          .then((res) {
        if (res) {
          var snackbar = SnackBar(
            content: Text("Successful Register !"),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false);
        } else {
          var snackbar = SnackBar(
            content: Text("Ooppss... Something went wrong"),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final txtTitle = Text(
      "Sign Up",
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
        child: Image.asset("assets/icons/ic_register.png"),
      ),
    );

    final etName = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: nameController,
      decoration: InputDecoration(
        hintText: 'Name',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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

    final etConPassword = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: conPasswordController,
      decoration: InputDecoration(
        hintText: 'Confirm Password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final etPhone = TextFormField(
      keyboardType: TextInputType.number,
      autofocus: false,
      controller: phoneController,
      decoration: InputDecoration(
        hintText: 'Phone Number',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final etTeam = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: teamController,
      decoration: InputDecoration(
        hintText: 'ID Team',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final btnRegister = Padding(
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
          child: Text('Sign Up',
              style: new TextStyle(fontSize: 16.0, color: Colors.white)),
          onPressed: () {
            register(context);
          },
        ),
      ),
    );

    final btnLogin = GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Text(
        "Already have an account ?, Sign in here !",
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
            fontSize: 14, fontWeight: FontWeight.w300, color: ColorPrimary),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        key: snackbarKey,
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
                etName,
                SizedBox(
                  height: 10,
                ),
                etEmail,
                SizedBox(
                  height: 10,
                ),
                etPassword,
                SizedBox(
                  height: 10,
                ),
                etConPassword,
                SizedBox(
                  height: 10,
                ),
                etPhone,
                SizedBox(
                  height: 10,
                ),
                etTeam,
                SizedBox(
                  height: 10,
                ),
                btnLogin,
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
              child: Text('Sign Up',
                  style: TextStyle(fontSize: 16.0, color: Colors.white)),
              onPressed: () {
                register(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}
