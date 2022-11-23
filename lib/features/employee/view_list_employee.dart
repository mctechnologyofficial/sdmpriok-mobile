import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sdm_priok/features/employee/view_add_employee.dart';
import 'package:sdm_priok/helpers/colours.dart';

import '../../helpers/strings.dart';

class ListEmployee extends StatefulWidget {
  const ListEmployee({Key? key}) : super(key: key);

  @override
  State<ListEmployee> createState() => _EmployeeState();
}

class _EmployeeState extends State<ListEmployee> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("List Employee"),
            backgroundColor: ColorPrimary,
          ),
          backgroundColor: ColorWhite,
          body: SingleChildScrollView(
            child: Column(
              children: [
                ChildKaryawan(1, "assets/icons/ic_avatar.png", "Alardo Carolos", "081234567890", "Admin", "Team A"),
                ChildKaryawan(1, "assets/icons/ic_avatar.png", "Alardo Carolos", "081234567890", "Admin", "Team A"),
                ChildKaryawan(1, "assets/icons/ic_avatar.png", "Alardo Carolos", "081234567890", "Admin", "Team A"),
                ChildKaryawan(1, "assets/icons/ic_avatar.png", "Alardo Carolos", "081234567890", "Admin", "Team A"),
                ChildKaryawan(1, "assets/icons/ic_avatar.png", "Alardo Carolos", "081234567890", "Admin", "Team A"),
                ChildKaryawan(1, "assets/icons/ic_avatar.png", "Alardo Carolos", "081234567890", "Admin", "Team A"),
                ChildKaryawan(1, "assets/icons/ic_avatar.png", "Alardo Carolos", "081234567890", "Admin", "Team A"),
                ChildKaryawan(1, "assets/icons/ic_avatar.png", "Alardo Carolos", "081234567890", "Admin", "Team A"),
                ChildKaryawan(1, "assets/icons/ic_avatar.png", "Alardo Carolos", "081234567890", "Admin", "Team A"),
                ChildKaryawan(1, "assets/icons/ic_avatar.png", "Alardo Carolos", "081234567890", "Admin", "Team A"),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: ColorPrimary,
            child: Text("+"),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => EmployeeAdd()));
            },
          ),
        )
    );
  }
}

class ChildKaryawan extends StatelessWidget {
  int id = 0;
  String image = "", name = "", phone = "", position = "", team = "";

  ChildKaryawan(this.id, this.image, this.name, this.phone, this.position, this.team) {}

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        width: double.infinity,
        color: Colors.white,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                height: 50,
                width: 50,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      margin: EdgeInsets.only(right: 10),
                      child: Text(
                        "Nama",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Text(
                      ": " + name,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 60,
                      margin: EdgeInsets.only(right: 10),
                      child: Text(
                        "Phone",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Text(
                      ": " + phone,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 60,
                      margin: EdgeInsets.only(right: 10),
                      child: Text(
                        "Position",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Text(
                      ": " + position,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 60,
                      margin: EdgeInsets.only(right: 10),
                      child: Text(
                        "Team",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Text(
                      ": " + team,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
