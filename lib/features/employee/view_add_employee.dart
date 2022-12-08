import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sdm_priok/features/employee/view_list_employee.dart';
import 'package:sdm_priok/features/team/view_detail_team.dart';
import 'package:sdm_priok/features/team/view_list_team.dart';
import 'package:sdm_priok/helpers/colours.dart';
import 'package:sdm_priok/models/responses/response_team.dart';
import 'package:sdm_priok/provider/employee_provider.dart';
import 'package:sdm_priok/provider/role_provider.dart';
import 'package:sdm_priok/provider/team_provider.dart';

class EmployeeAdd extends StatefulWidget {
  @override
  _EmployeeAddState createState() => _EmployeeAddState();
}

class _EmployeeAddState extends State<EmployeeAdd> {
  final TextEditingController nipController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController teamController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final snackbarKey = GlobalKey<ScaffoldState>();
  String dataRole = "";
  String dataTeam = "";
  String password = "";
  bool _isLoading = false;
  final List listTeam = ["Team A", "Team B", "Team C"];
  final List listPosition = ["Admin", "Supervisor", "Operator"];
  bool isShowed = true;
  File _imageFile = File("");

  void setPasswordVisibility() {
    setState(() {
      isShowed = !isShowed;
    });
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

  void addEmployees(BuildContext context) {
    if (nipController.text.isEmpty ||
        nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        teamController.text.isEmpty ||
        roleController.text.isEmpty ||
        _imageFile.path == "") {
      EasyLoading.showError('Please fill in all data !');
    } else {
      if (!_isLoading) {
        setState(() {
          _isLoading = true;
        });
        EasyLoading.show(status: 'Loading...');
        Provider.of<EmployeeProvider>(context, listen: false)
            .addEmployee(
                nipController.text,
                nameController.text,
                phoneController.text,
                emailController.text,
                passwordController.text,
                dataTeam,
                dataRole,
                _imageFile)
            .then((res) {
          if (res) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess('Successfully added data !');
            setState(() {
              _isLoading = false;
            });
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => ListEmployee()),
                (route) => false);
          } else {
            EasyLoading.dismiss();
            EasyLoading.showError(
                'Ooppss.. Something went wrong, please make sure your internet connection !');
            setState(() {
              _isLoading = false;
            });
          }
        });
      }
    }
  }

  Widget _popUpImage(BuildContext context) {
    return Transform.scale(
      scale: 1,
      child: Opacity(
        opacity: 1,
        child: CupertinoAlertDialog(
            content: Text("Choose Method"),
            actions: <Widget>[
              Container(
                color: Colors.white,
                child: CupertinoDialogAction(
                  child: Text(
                    'Camera',
                    style: new TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    _pilihCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Container(
                color: Colors.white,
                child: CupertinoDialogAction(
                  child: Text(
                    'Gallery',
                    style: new TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    _pilihGallery();
                    // delete();
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ]),
      ),
    );
  }

  _pilihGallery() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 1920.0, maxWidth: 1080.0);
    setState(() {
      _imageFile = image;
    });
  }

  _pilihCamera() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 1920.0, maxWidth: 1080.0);
    setState(() {
      _imageFile = image;
    });
  }

  @override
  void initState() {
    super.initState();
    // dataPosition = listPosition[0];
    // dataTeam = listTeam[0];
  }

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
                "Password",
                style: GoogleFonts.poppins(fontSize: 15),
              ),
              Container(
                child: TextField(
                  style: GoogleFonts.poppins(
                    height: 1,
                  ),
                  controller: passwordController,
                  autofocus: false,
                  obscureText: isShowed,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: ColorPrimary)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: setPasswordVisibility,
                  child: Container(
                    width: 130,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          isShowed
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          isShowed ? "Show Password" : "Hide Password",
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
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
              FutureBuilder(
                  future: Provider.of<RoleProvider>(context, listen: true)
                      .getRoles(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Consumer<RoleProvider>(
                        builder: (context, data, _) {
                          return Container(
                            width: double.infinity,
                            height: 55,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: ColorGrey),
                                borderRadius: BorderRadius.circular(15)),
                            child: DropdownButton(
                              value: dataRole == ""
                                  ? data.dataRoles[0].id.toString()
                                  : dataRole,
                              underline: SizedBox(),
                              isExpanded: true,
                              items: data.dataRoles.map((value) {
                                return DropdownMenuItem(
                                  child: Text(value.name),
                                  value: value.id.toString(),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  dataRole = value.toString();
                                  roleController.text = value.toString();
                                  // print(dataRole);
                                });
                              },
                            ),
                          );
                        },
                      );
                    }
                  }),
              SizedBox(
                height: 10,
              ),
              Text(
                "Team",
                style: GoogleFonts.poppins(fontSize: 15),
              ),
              FutureBuilder(
                  future: Provider.of<TeamProvider>(context, listen: true)
                      .getTeams(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Consumer<TeamProvider>(
                        builder: (context, data, _) {
                          return Container(
                            width: double.infinity,
                            height: 55,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: ColorGrey),
                                borderRadius: BorderRadius.circular(15)),
                            child: DropdownButton(
                              value: dataTeam == ""
                                  ? data.dataTeams[0].id.toString()
                                  : dataTeam,
                              underline: SizedBox(),
                              isExpanded: true,
                              items: data.dataTeams.map((value) {
                                return DropdownMenuItem(
                                  child: Text(value.name),
                                  value: value.id.toString(),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  dataTeam = value.toString();
                                  teamController.text = value.toString();
                                  // print(dataTeam);
                                });
                              },
                            ),
                          );
                        },
                      );
                    }
                  }),
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
                    child: _imageFile.path == ""
                        ? Row(
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
                                  style: TextStyle(
                                      fontSize: 15, color: ColorPrimary)),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.file(_imageFile,
                                  height: 100, width: 100, fit: BoxFit.cover),
                            ],
                          ),
                    onPressed: () {
                      showDialog(
                          // barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) =>
                              _popUpImage(context));
                    },
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
                addEmployees(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}
