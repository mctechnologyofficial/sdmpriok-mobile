import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sdm_priok/features/team/view_edit_team.dart';
import 'package:sdm_priok/provider/team_provider.dart';

import '../../helpers/colours.dart';

class DetailTeam extends StatefulWidget {
  final int dataId;

  DetailTeam({required this.dataId});

  @override
  State<DetailTeam> createState() => _DetailTeamState();
}

class _DetailTeamState extends State<DetailTeam> {
  bool _isLoading = false;
  int id = 0;
  String name = "";

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<TeamProvider>(context, listen: false)
          .detailTeam(widget.dataId)
          .then((response) {
        id = response.id;
        name = response.name;
      });
    });
    super.initState();
  }

  void deleteTeam() {
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
          Provider.of<TeamProvider>(context, listen: false)
              .deleteTeam(id)
              .then((res) {
            if (res) {
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Team deleted successfully !');
              setState(() {
                _isLoading = false;
              });
              Navigator.pop(context);
              Navigator.pop(context);
            } else {
              EasyLoading.dismiss();
              EasyLoading.showError('Team failed to delete !');
              Navigator.pop(context);
              setState(() {
                _isLoading = false;
              });
            }
          });
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation"),
      content: Text("Are you sure you want to delete this team ?"),
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
        title: Text("Detail Team"),
        backgroundColor: ColorPrimary,
      ),
      backgroundColor: ColorWhite,
      body: RefreshIndicator(
        onRefresh: () =>
            Provider.of<TeamProvider>(context, listen: false).getTeams(),
        color: ColorPrimary,
        child: Container(
          child: FutureBuilder(
              future:
                  Provider.of<TeamProvider>(context, listen: false).getTeams(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Consumer<TeamProvider>(
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
                                                    child: Image.asset(
                                                        "assets/icons/ic_team.png",
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
                                                    ChildData(
                                                        "ID",
                                                        widget.dataId
                                                            .toString()),
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
                    deleteTeam();
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
                        builder: (context) => TeamEdit(dataId: widget.dataId)));
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
