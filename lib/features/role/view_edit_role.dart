import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sdm_priok/features/role/view_list_role.dart';
import 'package:sdm_priok/helpers/colours.dart';
import 'package:sdm_priok/provider/role_provider.dart';

class RoleEdit extends StatefulWidget {
  final int dataId;

  RoleEdit({required this.dataId});

  @override
  _EmployeeEditState createState() => _EmployeeEditState();
}

class _EmployeeEditState extends State<RoleEdit> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController guardController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<RoleProvider>(context, listen: false)
          .detailRole(widget.dataId)
          .then((response) {
        nameController.text = response.name;
        guardController.text = response.guardName;
      });
    });
    super.initState();
  }

  void deleteEmployee() {}

  void updateRole(BuildContext context) {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      EasyLoading.show(status: 'Loading...');
      Provider.of<RoleProvider>(context, listen: false).updateRole(widget.dataId.toString(), nameController.text, guardController.text).then((res) {
        if (res) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess('Roles have been updated !');
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => ListRole()), (route) => false);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Role"),
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
              Text(
                "Guard Name",
                style: GoogleFonts.poppins(fontSize: 15),
              ),
              Container(
                height: 50,
                child: TextField(
                  style: GoogleFonts.poppins(
                    height: 1,
                  ),
                  controller: guardController,
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
                updateRole(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}
