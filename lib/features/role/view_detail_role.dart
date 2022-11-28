import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sdm_priok/features/employee/view_edit_employee.dart';
import 'package:sdm_priok/features/role/view_edit_role.dart';
import 'package:sdm_priok/provider/role_provider.dart';

import '../../helpers/colours.dart';

class DetailRole extends StatefulWidget {
  final int dataId;

  DetailRole({required this.dataId});

  @override
  State<DetailRole> createState() => _DetailRoleState();
}

class _DetailRoleState extends State<DetailRole> {
  String name = "", guard = "";

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<RoleProvider>(context, listen: false)
          .detailRole(widget.dataId)
          .then((response) {
        name = response.name;
        guard = response.guardName;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Detail Role"),
        backgroundColor: ColorPrimary,
      ),
      backgroundColor: ColorWhite,
      body: RefreshIndicator(
        onRefresh: () =>
            Provider.of<RoleProvider>(context, listen: false).getRoles(),
        color: ColorPrimary,
        child: Container(
          child: FutureBuilder(
              future: Provider.of<RoleProvider>(context, listen: false).getRoles(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Consumer<RoleProvider>(
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
                                                  bottomLeft: Radius.circular(20),
                                                  bottomRight: Radius.circular(20))),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Column(
                                            children: [
                                              Center(
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(50),
                                                    child: Image.asset(
                                                        "assets/icons/ic_role.png",
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
                                                          fontWeight: FontWeight.bold,
                                                          color: ColorWhitePrimary),
                                                      textAlign: TextAlign.center,
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
                                                      Icons.perm_identity,
                                                      color: ColorText,
                                                      size: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    ChildData("ID", widget.dataId.toString()),
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
                                                      Icons.admin_panel_settings,
                                                      color: ColorText,
                                                      size: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    ChildData("Guard Name", guard),
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
                    // submit(context);
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
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => RoleEdit(dataId: widget.dataId)));
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
