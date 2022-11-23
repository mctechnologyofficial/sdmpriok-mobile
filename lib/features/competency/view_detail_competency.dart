import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sdm_priok/helpers/strings.dart';

import '../../helpers/colours.dart';

class DetailCompetency extends StatefulWidget {
  const DetailCompetency({Key? key}) : super(key: key);

  @override
  State<DetailCompetency> createState() => _DetailCompetencyState();
}

class _DetailCompetencyState extends State<DetailCompetency> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Detail Competency"),
        backgroundColor: ColorPrimary,
      ),
      backgroundColor: ColorWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25)),
              child: SizedBox.fromSize(
                child: Image.network(
                    "http://1.bp.blogspot.com/-YvL5KpWSh-k/VdCJWpy0XzI/AAAAAAAABCs/1GyQnPY7SgY/s1600/Steam%2Bturbine.jpg",
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Tools Steam Turbin",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      dummyDesc,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Material(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 5,
            color: ColorPrimary,
            clipBehavior: Clip.antiAlias,
            child: MaterialButton(
              minWidth: 200.0,
              height: 50,
              color: ColorPrimary,
              child: Text('Start Exam', style: TextStyle(fontSize: 15, color: Colors.white)),
              onPressed: () {

              },
            ),
          ),
        ),
      ),
    ));
  }
}
