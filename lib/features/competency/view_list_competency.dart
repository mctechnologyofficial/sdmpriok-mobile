import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sdm_priok/features/competency/view_detail_competency.dart';

import '../../helpers/colours.dart';

class ListCompetency extends StatefulWidget {
  const ListCompetency({Key? key}) : super(key: key);

  @override
  State<ListCompetency> createState() => _ListCompetencyState();
}

class _ListCompetencyState extends State<ListCompetency> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("List Competency"),
            backgroundColor: ColorPrimary,
          ),
          backgroundColor: ColorWhite,
          body: SingleChildScrollView(
            child: Column(
              children: [
                ChildCompetency(1, "http://1.bp.blogspot.com/-YvL5KpWSh-k/VdCJWpy0XzI/AAAAAAAABCs/1GyQnPY7SgY/s1600/Steam%2Bturbine.jpg", "Tools Steam Turbin"),
                ChildCompetency(1, "http://1.bp.blogspot.com/-YvL5KpWSh-k/VdCJWpy0XzI/AAAAAAAABCs/1GyQnPY7SgY/s1600/Steam%2Bturbine.jpg", "Tools Steam Turbin"),
                ChildCompetency(1, "http://1.bp.blogspot.com/-YvL5KpWSh-k/VdCJWpy0XzI/AAAAAAAABCs/1GyQnPY7SgY/s1600/Steam%2Bturbine.jpg", "Tools Steam Turbin"),
              ],
            ),
          ),
        )
    );
  }
}

class ChildCompetency extends StatelessWidget {
  int id = 0;
  String image = "", name = "";

  ChildCompetency(this.id, this.image, this.name) {

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        // if (id == 1) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailCompetency()));
        // } else {
        //
        // }
      },
      child: Card(
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
                child: Image.network(
                  image,
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                name,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.left,
              )
            ],
          ),
        ),
      ),
    );
  }
}