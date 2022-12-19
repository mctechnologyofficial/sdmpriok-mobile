import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sdm_priok/helpers/colours.dart';
import 'package:sdm_priok/provider/organization_provider.dart';

import '../../helpers/strings.dart';

class ListOrganizationMember extends StatefulWidget {
  final int idTeam;
  const ListOrganizationMember({Key? key, required this.idTeam}) : super(key: key);

  @override
  State<ListOrganizationMember> createState() => _ListOrganizationMemberState();
}

class _ListOrganizationMemberState extends State<ListOrganizationMember> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 3;
    final double itemWidth = size.width / 2;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("List Organization Member"),
        backgroundColor: ColorPrimary,
      ),
      backgroundColor: ColorWhite,
      body: RefreshIndicator(
        onRefresh: () => Provider.of<OrganizationProvider>(context, listen: false).getOrganizationMember(widget.idTeam),
        color: ColorPrimary,
        child: Container(
          margin: EdgeInsets.all(10),
          child: FutureBuilder(
              future: Provider.of<OrganizationProvider>(context, listen: false).getOrganizationMember(widget.idTeam),
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
                        itemCount: data.dataOrganizationMember.length,
                        itemBuilder: (_, i) => InkWell(
                          onTap: () {
                            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailEmployee(dataHash: data.dataEmployee[i].hash)));
                          },
                          child: ChildKaryawan(
                              data.dataOrganizationMember[i].id,
                              data.dataOrganizationMember[i].image == null ? "" : data.dataOrganizationMember[i].image,
                              data.dataOrganizationMember[i].name == null ? "" : data.dataOrganizationMember[i].name,
                              data.dataOrganizationMember[i].nip == null ? "" : data.dataOrganizationMember[i].nip,
                              data.dataOrganizationMember[i].phone == null ? "" : data.dataOrganizationMember[i].phone,
                              data.dataOrganizationMember[i].email == null ? "" : data.dataOrganizationMember[i].email),
                        ),
                      );
                    },
                  );
                }
              }),
        ),
      ),
    ));
  }
}

class ChildKaryawan extends StatelessWidget {
  int id = 0;
  String image = "", name = "", nip = "", phone = "",  email = "";

  ChildKaryawan(
      this.id, this.image, this.name, this.nip, this.phone, this.email) {}

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
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10,),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 50,
                            child: Text(
                              "NIP",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            width: 10,
                            child: Text(
                              " : ",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Text(
                            nip,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 50,
                            child: Text(
                              "Phone",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            width: 10,
                            child: Text(
                              " : ",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Text(
                            phone,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 50,
                            child: Text(
                              "Email",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            width: 10,
                            child: Text(
                              " : ",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Text(
                            email,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ],
                  ),
                  scrollDirection: Axis.horizontal,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
