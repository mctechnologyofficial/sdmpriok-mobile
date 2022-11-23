import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../helpers/colours.dart';

class Utilities extends StatelessWidget {
  const Utilities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Utilities"),
        backgroundColor: ColorPrimary,
      ),
      backgroundColor: ColorWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Features(1, "assets/icons/ic_carousel.png", "Slider"),
            Features(2, "assets/icons/ic_exam.png", "Competency"),
          ],
        ),
      ),
    );
  }
}

class Features extends StatelessWidget {
  int id;
  String image;
  String title;

  Features(this.id, this.image, this.title) {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // if (id == 1) {
        //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => Employee()));
        // }else if(id == 2){
        //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => Mentoring()));
        // }else if(id == 3){
        //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => Chart()));
        // } else if(id == 4){
        //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => Utilities()));
        // }
      },
      child: Card(
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 2,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    image,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 10,),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: ColorGrey),
                  ),
                ],
              ),
              Icon(
                Icons.keyboard_arrow_right_rounded,
                color: ColorGrey,
                size: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
