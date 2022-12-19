import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sdm_priok/features/employee/view_list_employee.dart';
import 'package:sdm_priok/features/organization/view_list_organization.dart';
import 'package:sdm_priok/features/role/view_list_role.dart';
import 'package:sdm_priok/features/team/view_list_team.dart';

import '../../helpers/colours.dart';

class Employee extends StatefulWidget {
  const Employee({Key? key}) : super(key: key);

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee"),
        backgroundColor: ColorPrimary,
      ),
      backgroundColor: ColorWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Features(1, "assets/icons/ic_employee.png", "Employee"),
            Features(2, "assets/icons/ic_team.png", "Team"),
            Features(3, "assets/icons/ic_organization.png", "Organization"),
            Features(4, "assets/icons/ic_roles.png", "Role"),
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
        if (id == 1) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListEmployee()));
        }else if (id == 2) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListTeam()));
        }else if (id == 3) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListOrganization()));
        }else if (id == 4) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListRole()));
        }
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
                  SizedBox(
                    width: 10,
                  ),
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
