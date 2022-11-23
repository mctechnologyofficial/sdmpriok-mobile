import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sdm_priok/helpers/colours.dart';

class EmployeeAdd extends StatefulWidget {
  @override
  _EmployeeAddState createState() => _EmployeeAddState();
}

class _EmployeeAddState extends State<EmployeeAdd> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final snackbarKey = GlobalKey<ScaffoldState>();
  FocusNode salaryNode = FocusNode();
  FocusNode ageNode = FocusNode();
  String dataPosition = "";
  String dataTeam = "";
  bool _isLoading = false;
  final List listTeam = ["Team A", "Team B", "Team C"];
  final List listPosition = ["Admin", "Supervisor", "Operator"];

  // void submit(BuildContext context) {
  //   if (!_isLoading) {
  //     // snackbarKey.currentState.showSnackBar(snackbar);
  //     // setState(() {
  //     //   _isLoading = true;
  //     // });
  //     Provider.of<EmployeeProvider>(context, listen: false)
  //         .storeEmployee(_name.text, _salary.text, _age.text)
  //         .then((res) {
  //       if (res) {
  //         var snackbar = SnackBar(
  //           content: Text("Successfully Added Employees !"),
  //         );
  //         ScaffoldMessenger.of(context).showSnackBar(snackbar);
  //         Navigator.of(context).pushAndRemoveUntil(
  //             MaterialPageRoute(builder: (context) => Employee()),
  //             (route) => false);
  //       } else {
  //         var snackbar = SnackBar(
  //           content: Text("Ooppss... Something went wrong"),
  //         );
  //         ScaffoldMessenger.of(context).showSnackBar(snackbar);
  //       }
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    dataPosition = listPosition[0];
    dataTeam = listTeam[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: snackbarKey,
      appBar: AppBar(
        title: Text("Add Employee"),
        backgroundColor: ColorPrimary,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Text(
              "Name",
              style: GoogleFonts.poppins(fontSize: 15),
            ),
            Container(
              height: 50,
              child: TextField(
                style: GoogleFonts.poppins(
                  height: 1,
                ),
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: ColorPrimary,
                      )),
                ),
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(salaryNode);
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Phone Number",
              style: GoogleFonts.poppins(fontSize: 15),
            ),
            Container(
              height: 50,
              child: TextField(
                style: GoogleFonts.poppins(
                  height: 1,
                ),
                controller: phoneController,
                focusNode: salaryNode,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: ColorPrimary,
                      )),
                ),
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(ageNode);
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Email",
              style: GoogleFonts.poppins(fontSize: 15),
            ),
            Container(
              child: TextField(
                style: GoogleFonts.poppins(
                  height: 1,
                ),
                controller: emailController,
                focusNode: ageNode,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: ColorPrimary)),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Position",
              style: GoogleFonts.poppins(fontSize: 15),
            ),
            Container(
              width: double.infinity,
              height: 55,
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: ColorGrey),
                  borderRadius: BorderRadius.circular(15)),
              child: DropdownButton(
                value: dataPosition,
                underline: SizedBox(),
                isExpanded: true,
                items: listPosition.map((value) {
                  return DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    dataPosition = value as String;
                  });
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Team",
              style: GoogleFonts.poppins(fontSize: 15),
            ),
            Container(
              width: double.infinity,
              height: 55,
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: ColorGrey),
                  borderRadius: BorderRadius.circular(15)),
              child: DropdownButton(
                value: dataTeam,
                underline: SizedBox(),
                isExpanded: true,
                items: listTeam.map((value) {
                  return DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    dataTeam = value as String;
                  });
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Photo",
              style: GoogleFonts.poppins(fontSize: 15),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(color: ColorPrimary),
                  borderRadius: BorderRadius.circular(15),
              ),
              child: Material(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                clipBehavior: Clip.antiAlias,
                child: MaterialButton(
                  minWidth: 200.0,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.folder,
                        color: ColorPrimary,
                        size: 25,
                      ),
                      SizedBox(width: 5,),
                      Text('Browse', style: TextStyle(
                          fontSize: 15, color: ColorPrimary)
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
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
              child: Text('Submit',
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              onPressed: () {
                // submit(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}
