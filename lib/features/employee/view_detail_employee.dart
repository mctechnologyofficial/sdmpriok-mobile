import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sdm_priok/features/employee/view_edit_employee.dart';

import '../../helpers/colours.dart';
import '../../provider/employee_provider.dart';

class DetailEmployee extends StatefulWidget {
  final String dataHash;

  DetailEmployee({required this.dataHash});

  @override
  State<DetailEmployee> createState() => _DetailEmployeeState();
}

class _DetailEmployeeState extends State<DetailEmployee> {
  bool _isLoading = false;
  String nip = "",
      name = "",
      email = "",
      phone = "",
      image = "",
      team = "",
      role = "";

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<EmployeeProvider>(context, listen: false)
          .detailEmployee(widget.dataHash)
          .then((response) {
        nip = response.nip;
        name = response.name;
        email = response.email;
        phone = response.phone;
        image = response.image;
        team = response.teams.name;
        role = response.roles[0].name;
      });
    });
    super.initState();
  }

  void deleteEmployee() {
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        if (!_isLoading) {
          setState(() {
            _isLoading = true;
          });
          Provider.of<EmployeeProvider>(context, listen: false).deleteEmployee(widget.dataHash).then((res) {
            if (res) {
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Employee deleted successfully !');
              setState(() {
                _isLoading = false;
              });
              Navigator.pop(context);
              Navigator.pop(context);
            } else {
              EasyLoading.dismiss();
              EasyLoading.showError('Employee failed to delete !');
              Navigator.pop(context);
              setState(() {
                _isLoading = false;
              });
            }
          });
        }
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation"),
      content: Text("Are you sure you want to delete this employee ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Detail Employee"),
        backgroundColor: ColorPrimary,
      ),
      backgroundColor: ColorWhite,
      body: RefreshIndicator(
        onRefresh: () =>
            Provider.of<EmployeeProvider>(context, listen: false).getEmployee(),
        color: ColorPrimary,
        child: Container(
          child: FutureBuilder(
              future: Provider.of<EmployeeProvider>(context, listen: false)
                  .getEmployee(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Consumer<EmployeeProvider>(
                    builder: (context, data, _) {
                      return Scaffold(
                        body: SingleChildScrollView(
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                              color: ColorPrimary,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20))),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Column(
                                            children: [
                                              Center(
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    child: image.isEmpty
                                                        ? Image.asset(
                                                            "assets/icons/ic_avatar.png",
                                                            height: 100,
                                                            width: 100,
                                                            fit: BoxFit.cover)
                                                        : Image.network(
                                                            "https://humancapitalpriokpomu.com/" +
                                                                image,
                                                            height: 100,
                                                            width: 100,
                                                            fit: BoxFit.cover)),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Column(
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      name,
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              ColorWhitePrimary),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      nip,
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color:
                                                              ColorWhitePrimary),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(20),
                                        child: Column(
                                          children: [
                                            Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.email_outlined,
                                                      color: ColorText,
                                                      size: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    ChildData("Email", email),
                                                  ],
                                                ),
                                                SizedBox(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        top: 5, bottom: 5),
                                                    height: 1,
                                                    color: ColorText,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.phone_android,
                                                      color: ColorText,
                                                      size: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    ChildData("Phone", phone),
                                                  ],
                                                ),
                                                SizedBox(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        top: 5, bottom: 5),
                                                    height: 1,
                                                    color: ColorText,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.group,
                                                      color: ColorText,
                                                      size: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    ChildData("Team", team),
                                                  ],
                                                ),
                                                SizedBox(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        top: 5, bottom: 5),
                                                    height: 1,
                                                    color: ColorText,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .admin_panel_settings,
                                                      color: ColorText,
                                                      size: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    ChildData("Role", role),
                                                  ],
                                                ),
                                                SizedBox(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        top: 5, bottom: 5),
                                                    height: 1,
                                                    color: ColorText,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
        ),
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                color: ColorPrimary,
                clipBehavior: Clip.antiAlias,
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width / 2.2,
                  height: 50,
                  color: ColorRed,
                  child: Text('Delete',
                      style: TextStyle(fontSize: 15, color: Colors.white)),
                  onPressed: () {
                    deleteEmployee();
                  },
                ),
              ),
              Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                color: ColorPrimary,
                clipBehavior: Clip.antiAlias,
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width / 2.2,
                  height: 50,
                  color: ColorGreen,
                  child: Text('Edit',
                      style: TextStyle(fontSize: 15, color: Colors.white)),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            EmployeeEdit(hash: widget.dataHash)));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class ChildData extends StatelessWidget {
  String title = "", name = "";

  ChildData(this.title, this.name) {}

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.left,
        ),
        Text(
          name,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}
