import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sdm_priok/helpers/colours.dart';

import '../../provider/employee_provider.dart';

class EmployeeEdit extends StatefulWidget {
  final String hash;

  EmployeeEdit({required this.hash});

  @override
  _EmployeeEditState createState() => _EmployeeEditState();
}

class _EmployeeEditState extends State<EmployeeEdit> {
  final TextEditingController nipController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final snackbarKey = GlobalKey<ScaffoldState>();
  String dataPosition = "";
  String dataTeam = "";
  String password = "";
  bool _isLoading = false;
  final List listTeam = ["Team A", "Team B", "Team C"];
  final List listPosition = ["Admin", "Supervisor", "Operator"];

  @override
  void initState() {
    dataPosition = listPosition[0];
    dataTeam = listTeam[0];
    Future.delayed(Duration.zero, () {
      Provider.of<EmployeeProvider>(context, listen: false).detailEmployee(widget.hash).then((response) {
        nipController.text = response.nip;
        nameController.text = response.name;
        emailController.text = response.email;
        phoneController.text = response.phone;
        // team = response.teams.name;
        // role = response.roles[0].name;
      });
    });
    super.initState();
  }

  void deleteEmployee(){

  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      key: snackbarKey,
      appBar: AppBar(
        title: Text("Add Employee"),
        backgroundColor: ColorPrimary,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "NIP",
                style: GoogleFonts.poppins(fontSize: 15),
              ),
              Container(
                height: 50,
                child: TextField(
                  style: GoogleFonts.poppins(
                    height: 1,
                  ),
                  controller: nipController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: ColorPrimary,
                        )),
                  ),
                  onSubmitted: (_) {
                    // FocusScope.of(context).requestFocus(salaryNode);
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
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
                    // FocusScope.of(context).requestFocus(salaryNode);
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
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: ColorPrimary,
                        )),
                  ),
                  onSubmitted: (_) {
                    // FocusScope.of(context).requestFocus(ageNode);
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
                  keyboardType: TextInputType.emailAddress,
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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
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
                        SizedBox(
                          width: 5,
                        ),
                        Text('Browse',
                            style:
                                TextStyle(fontSize: 15, color: ColorPrimary)),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
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
