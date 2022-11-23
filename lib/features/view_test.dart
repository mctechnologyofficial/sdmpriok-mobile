import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sdm_priok/helpers/colours.dart';
import 'package:sdm_priok/helpers/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/data_helper.dart';

class HomePage extends StatefulWidget {
  static String TagHome = "HomePage";

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  SharedPreferences? sharedPref;
  DataHelper dataHelper = new DataHelper();

  @override
  void initState() {
    super.initState();
    initializePreference().whenComplete((){
      setState(() {});
    });
  }

  Future<void> initializePreference() async{
    this.sharedPref = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    final navbar = Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(
            "assets/icons/ic_avatar.png",
            height: 50,
            width: 50,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          children: [
            Text(
              "Hi, ${this.sharedPref?.getString("Name")}",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      ],
    );

    final etSearch = Row(
      children: [
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 2,
          child: Container(
            width: 240,
            height: 40,
            margin: EdgeInsets.all(5),
            child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Search courses...',
                border: InputBorder.none,
                fillColor: ColorWhitePrimary,
                filled: true,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: (){
            dataHelper.clearDatas();
          },
          child: Material(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 2,
            color: ColorPrimary,
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Image.asset(
                "assets/icons/ic_search.png",
                height: 20,
                width: 20,
              ),
            ),
          ),
        )
      ],
    );

    final txtTitle = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Courses",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        )
      ],
    );

    return Scaffold(
      backgroundColor: ColorWhiteSecondary,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  navbar,
                  SizedBox(
                    height: 20,
                  ),
                  etSearch,
                  SizedBox(
                    height: 20,
                  ),
                  txtTitle,
                  ChildCourse(1, "assets/icons/ic_course.jpg", "Kelas 1", dummyDesc),
                  ChildCourse(1, "assets/icons/ic_course.jpg", "Kelas 1", dummyDesc),
                  ChildCourse(1, "assets/icons/ic_course.jpg", "Kelas 1", dummyDesc),
                  ChildCourse(1, "assets/icons/ic_course.jpg", "Kelas 1", dummyDesc),
                  ChildCourse(1, "assets/icons/ic_course.jpg", "Kelas 1", dummyDesc),
                  ChildCourse(1, "assets/icons/ic_course.jpg", "Kelas 1", dummyDesc),
                  ChildCourse(1, "assets/icons/ic_course.jpg", "Kelas 1", dummyDesc),
                ],
              ),
            )),
      ),
    );
  }
}

class ChildCourse extends StatelessWidget {
  int id = 0;
  String image = "", title = "", desc = "";

  ChildCourse(this.id, this.image, this.title, this.desc) {}

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        width: double.infinity,
        color: Colors.white,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                height: 80,
                width: 80,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  width: 200,
                  child: Text(desc,
                    maxLines: 2,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
