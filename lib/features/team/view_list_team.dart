import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sdm_priok/features/employee/view_add_employee.dart';
import 'package:sdm_priok/helpers/colours.dart';

import '../../helpers/strings.dart';

class ListTeam extends StatefulWidget {
  const ListTeam({Key? key}) : super(key: key);

  @override
  State<ListTeam> createState() => _TeamState();
}

class _TeamState extends State<ListTeam> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("List Team"),
            backgroundColor: ColorPrimary,
          ),
          backgroundColor: ColorWhite,
          body: SingleChildScrollView(
            child: Column(
              children: [
                ChildTeam(1, "assets/icons/ic_team.png", "Team A"),
                ChildTeam(2, "assets/icons/ic_team.png", "Team B"),
                ChildTeam(3, "assets/icons/ic_team.png", "Team C"),
                ChildTeam(4, "assets/icons/ic_team.png", "Team D"),
                ChildTeam(5, "assets/icons/ic_team.png", "Team E"),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: ColorPrimary,
            child: Text("+"),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => EmployeeAdd()));
            },
          ),
        )
    );
  }
}

class ChildTeam extends StatelessWidget {
  int id = 0;
  String image = "", name = "";

  ChildTeam(this.id, this.image, this.name) {}

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
    );
  }
}
