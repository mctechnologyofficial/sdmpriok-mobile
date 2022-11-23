import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sdm_priok/features/auth/view_login.dart';
import 'package:sdm_priok/helpers/colours.dart';
import 'package:sdm_priok/helpers/data_helper.dart';

import '../features/homes/view_home_admin.dart';

class BottomDialog {
  DataHelper dataHelper = new DataHelper();

  void showBottomDialog(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "showGeneralDialog",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 400),
      context: context,
      pageBuilder: (context, _, __) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: DialogContent(context),
        );
      },
      transitionBuilder: (_, animation1, __, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(animation1),
          child: child,
        );
      },
    );
  }

  Widget DialogContent(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: double.maxFinite,
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Material(
          child: Column(
            children: [OpsiEditProfile(), OpsiSignOut(context)],
          ),
        ),
      ),
    );
  }

  Widget OpsiEditProfile() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        color: ColorWhite,
        child: Row(
          children: [
            Image.asset(
              "assets/icons/ic_edit_profile.png",
              width: 35,
              height: 35,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Edit Profile",
              style: GoogleFonts.poppins(
                  fontSize: 15, fontWeight: FontWeight.w300, color: ColorGrey),
            ),
          ],
        ),
      ),
    );
  }

  Widget OpsiSignOut(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
          dataHelper.clearDatas();
          return LoginPage();
        }));
      },
      child: Container(
        color: ColorWhite,
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          children: [
            Image.asset(
              "assets/icons/ic_signout.png",
              width: 35,
              height: 35,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Sign Out",
              style: GoogleFonts.poppins(
                  fontSize: 15, fontWeight: FontWeight.w300, color: ColorGrey),
            ),
          ],
        ),
      ),
    );
  }
}
