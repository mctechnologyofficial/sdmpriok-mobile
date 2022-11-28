import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sdm_priok/features/employee/view_add_employee.dart';
import 'package:sdm_priok/features/role/view_add_role.dart';
import 'package:sdm_priok/features/role/view_detail_role.dart';
import 'package:sdm_priok/helpers/colours.dart';

import '../../helpers/strings.dart';
import '../../provider/role_provider.dart';

class ListRole extends StatefulWidget {
  const ListRole({Key? key}) : super(key: key);

  @override
  State<ListRole> createState() => _TeamState();
}

class _TeamState extends State<ListRole> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 5;
    final double itemWidth = size.width / 2;

    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("List Role"),
            backgroundColor: ColorPrimary,
          ),
          backgroundColor: ColorWhite,
          body: RefreshIndicator(
            onRefresh: () => Provider.of<RoleProvider>(context, listen: true).getRoles(),
            color: ColorPrimary,
            child: Container(
              margin: EdgeInsets.all(10),
              child: FutureBuilder(
                  future: Provider.of<RoleProvider>(context, listen: true).getRoles(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Consumer<RoleProvider>(
                        builder: (context, data, _) {
                          return GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: (itemWidth / itemHeight),
                              crossAxisCount: 2,
                            ),
                            itemCount: data.dataRoles.length,
                            itemBuilder: (_, i) => InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailRole(dataId: data.dataRoles[i].id)));
                              },
                              child: ChildTeam(data.dataRoles[i].id, "assets/icons/ic_role.png", data.dataRoles[i].name),
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
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => RoleAdd()));
            },
          ),
        )
    );
  }
}

class ChildTeam extends StatelessWidget {
  int id = 0;
  String image = "", name = "";

  ChildTeam(this.id, this.image, this.name) {}

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
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                height: 50,
                width: 50,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              name,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
