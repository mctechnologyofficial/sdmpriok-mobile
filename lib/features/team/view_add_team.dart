import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sdm_priok/features/team/view_list_team.dart';
import 'package:sdm_priok/helpers/colours.dart';
import 'package:sdm_priok/provider/team_provider.dart';

class TeamAdd extends StatefulWidget {
  @override
  _TeamAddState createState() => _TeamAddState();
}

class _TeamAddState extends State<TeamAdd> {
  final TextEditingController nameController = TextEditingController();
  bool _isLoading = false;

  void addTeam(BuildContext context) {
    if (nameController.text.isEmpty) {
      EasyLoading.showError('Please fill in all data !');
    } else {
      if (!_isLoading) {
        setState(() {
          _isLoading = true;
        });
        EasyLoading.show(status: 'Loading...');
        Provider.of<TeamProvider>(context, listen: false).addTeam(nameController.text).then((res) {
          if (res) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess('Successfully added team !');
            setState(() {
              _isLoading = false;
            });
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => ListTeam()), (route) => false);
          } else {
            EasyLoading.dismiss();
            EasyLoading.showError('Ooppss.. Something went wrong, please make sure your internet connection !');
            setState(() {
              _isLoading = false;
            });
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Team"),
        backgroundColor: ColorPrimary,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                addTeam(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}
