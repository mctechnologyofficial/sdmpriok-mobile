import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sdm_priok/features/employee/view_add_employee.dart';
import 'package:sdm_priok/features/employee/view_list_employee.dart';
import 'package:sdm_priok/features/organization/view_list_member.dart';
import 'package:sdm_priok/features/team/view_add_team.dart';
import 'package:sdm_priok/features/team/view_detail_team.dart';
import 'package:sdm_priok/helpers/colours.dart';
import 'package:sdm_priok/provider/organization_provider.dart';
import 'package:sdm_priok/provider/team_provider.dart';

import '../../helpers/strings.dart';

class ListOrganization extends StatefulWidget {
  const ListOrganization({Key? key}) : super(key: key);

  @override
  State<ListOrganization> createState() => _ListOrganizationState();
}

class _ListOrganizationState extends State<ListOrganization> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 5;
    final double itemWidth = size.width / 2;

    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("List Organization"),
            backgroundColor: ColorPrimary,
          ),
          backgroundColor: ColorWhite,
          body: RefreshIndicator(
            onRefresh: () => Provider.of<OrganizationProvider>(context, listen: true).getOrganization(),
            color: ColorPrimary,
            child: Container(
              margin: EdgeInsets.all(10),
              child: FutureBuilder(
                  future: Provider.of<OrganizationProvider>(context, listen: true).getOrganization(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Consumer<OrganizationProvider>(
                        builder: (context, data, _) {
                          return GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: (itemWidth / itemHeight),
                              crossAxisCount: 2,
                            ),
                            itemCount: data.dataOrganization.length,
                            itemBuilder: (_, i) => InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListOrganizationMember(idTeam: data.dataOrganization[i].id)));
                              },
                              child: ChildTeam(data.dataOrganization[i].id, "assets/icons/ic_team.png", data.dataOrganization[i].name),
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
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => TeamAdd()));
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