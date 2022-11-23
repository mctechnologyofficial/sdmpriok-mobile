import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sdm_priok/features/employee/view_add_employee.dart';
import 'package:sdm_priok/features/employee/view_detail_employee.dart';
import 'package:sdm_priok/helpers/colours.dart';

import '../../helpers/strings.dart';
import '../../provider/employee_provider.dart';

class ListEmployee extends StatefulWidget {
  const ListEmployee({Key? key}) : super(key: key);

  @override
  State<ListEmployee> createState() => _EmployeeState();
}

class _EmployeeState extends State<ListEmployee> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 3.8;
    final double itemWidth = size.width / 2;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("List Employee"),
        backgroundColor: ColorPrimary,
      ),
      backgroundColor: ColorWhite,
      body: RefreshIndicator(
        onRefresh: () =>
            Provider.of<EmployeeProvider>(context, listen: false).getEmployee(),
        color: ColorPrimary,
        child: Container(
          margin: EdgeInsets.all(10),
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
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: (itemWidth / itemHeight),
                          crossAxisCount: 2,
                        ),
                        itemCount: data.dataEmployee.length,
                        itemBuilder: (_, i) => InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailEmployee(
                                    hash: data.dataEmployee[i].hash)));
                          },
                          child: ChildKaryawan(
                              int.parse(data.dataEmployee[i].nip.isEmpty
                                  ? "0"
                                  : data.dataEmployee[i].nip),
                              data.dataEmployee[i].image == null
                                  ? ""
                                  : data.dataEmployee[i].image,
                              data.dataEmployee[i].name,
                              data.dataEmployee[i].phone,
                              data.dataEmployee[i].roles.length > 0
                                  ? data.dataEmployee[i].roles[0].name
                                  : "Unknown",
                              data.dataEmployee[i].teams.name),
                        ),
                      );
                    },
                  );
                }
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorPrimary,
        child: Text("+"),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => EmployeeAdd()));
        },
      ),
    ));
  }
}

class ChildKaryawan extends StatelessWidget {
  int id = 0;
  String image = "", name = "", phone = "", position = "", team = "";

  ChildKaryawan(
      this.id, this.image, this.name, this.phone, this.position, this.team) {}

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: image.isEmpty
                    ? Image.asset("assets/icons/ic_avatar.png",
                        height: 50, width: 50, fit: BoxFit.cover)
                    : Image.network(
                        "https://humancapitalpriokpomu.com/" + image,
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover)),
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Center(
                  child: Text(
                    phone,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Center(
                  child: Text(
                    position,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Center(
                  child: Text(
                    team,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
