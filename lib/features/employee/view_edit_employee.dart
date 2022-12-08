import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sdm_priok/features/employee/view_detail_employee.dart';
import 'package:sdm_priok/features/employee/view_list_employee.dart';
import 'package:sdm_priok/helpers/colours.dart';
import 'package:sdm_priok/provider/role_provider.dart';
import 'package:sdm_priok/provider/team_provider.dart';

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
  final TextEditingController teamController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final snackbarKey = GlobalKey<ScaffoldState>();
  String dataRole = "";
  String dataTeam = "";
  String password = "";
  String imagePath = "";
  File _imageFile = File("");
  bool _isLoading = false;
  final List listTeam = ["Team A", "Team B", "Team C"];
  final List listPosition = ["Admin", "Supervisor", "Operator"];

  @override
  void initState() {
    print(widget.hash);
    // dataPosition = listPosition[0];
    // dataTeam = listTeam[0];
    Future.delayed(Duration.zero, () {
      Provider.of<EmployeeProvider>(context, listen: false)
          .detailEmployee(widget.hash)
          .then((response) {
        nipController.text = response.nip;
        nameController.text = response.name;
        emailController.text = response.email;
        phoneController.text = response.phone;
        teamController.text = response.teamId;
        roleController.text = response.roles[0].id.toString();
        setState(() {
          imagePath = response.image;
        });
        // team = response.teams.name;
        // role = response.roles[0].name;
      });
    });
    super.initState();
  }

  void deleteEmployee() {}

  void updateEmployees(BuildContext context) {
    if (_imageFile.path != "") {
      if (!_isLoading) {
        setState(() {
          _isLoading = true;
        });
        EasyLoading.show(status: 'Loading...');
        Provider.of<EmployeeProvider>(context, listen: false)
            .updateEmployee(
                widget.hash,
                nipController.text,
                nameController.text,
                phoneController.text,
                emailController.text,
                teamController.text,
                roleController.text,
                _imageFile)
            .then((res) {
          if (res) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess('Successfully Update Data !');
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
    } else {
      if (!_isLoading) {
        setState(() {
          _isLoading = true;
        });
        EasyLoading.show(status: 'Loading...');
        Provider.of<EmployeeProvider>(context, listen: false)
            .updateEmployeeWithoutImage(
                widget.hash,
                nipController.text,
                nameController.text,
                phoneController.text,
                emailController.text,
                teamController.text,
                roleController.text)
            .then((res) {
          if (res) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess('Successfully Update Data !');
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

  imageWidget() {
    if (_imageFile.path != "") {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.file(_imageFile, height: 100, width: 100, fit: BoxFit.cover),
        ],
      );
    } else if (imagePath != "") {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // imagePath == ""
          //     ? Image.asset("assets/icons/ic_avatar.png",
          //         height: 100, width: 100, fit: BoxFit.cover)
          //     :
          Image.network("https://humancapitalpriokpomu.com/" + imagePath,
              height: 100, width: 100, fit: BoxFit.cover)
        ],
      );
    } else if (_imageFile.path == "") {
      return Row(
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
          Text('Browse', style: TextStyle(fontSize: 15, color: ColorPrimary)),
        ],
      );
      // backgroundImage: new FileImage(_imageFile),;
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
  Widget build(BuildContext context) {
    return Scaffold(
      key: snackbarKey,
      appBar: AppBar(
        title: Text("Edit Employee"),
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
                              value: roleController.text,
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
                              value: teamController.text,
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
                    child: imageWidget(),
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
                updateEmployees(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}
