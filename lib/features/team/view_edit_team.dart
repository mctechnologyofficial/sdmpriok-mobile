import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sdm_priok/features/team/view_list_team.dart';
import 'package:sdm_priok/helpers/colours.dart';
import 'package:sdm_priok/provider/team_provider.dart';

class TeamEdit extends StatefulWidget {
  final int dataId;

  TeamEdit({required this.dataId});

  @override
  _TeamEditState createState() => _TeamEditState();
}

class _TeamEditState extends State<TeamEdit> {
  final TextEditingController nameController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<TeamProvider>(context, listen: false).detailTeam(widget.dataId).then((response) {
        nameController.text = response.name;
      });
    });
    super.initState();
  }

  void deleteEmployee() {}

  void updateTeam(BuildContext context) {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      EasyLoading.show(status: 'Loading...');
      Provider.of<TeamProvider>(context, listen: false)
          .updateTeam(widget.dataId.toString(), nameController.text)
          .then((res) {
        if (res) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess('Team have been updated !');
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => ListTeam()),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Team"),
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
                updateTeam(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}
