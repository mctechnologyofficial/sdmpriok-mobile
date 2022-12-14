import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sdm_priok/features/competency/view_detail_competency.dart';
import 'package:sdm_priok/provider/competency_provider.dart';

import '../../helpers/colours.dart';

class ListCompetency extends StatefulWidget {
  const ListCompetency({Key? key}) : super(key: key);

  @override
  State<ListCompetency> createState() => _ListCompetencyState();
}

class _ListCompetencyState extends State<ListCompetency> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 5;
    final double itemWidth = size.width / 2;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("List Competencies"),
        backgroundColor: ColorPrimary,
      ),
      backgroundColor: ColorWhite,
      body: RefreshIndicator(
        onRefresh: () => Provider.of<CompetencyProvider>(context, listen: false)
            .getCompetencys(),
        color: ColorPrimary,
        child: Container(
          margin: EdgeInsets.all(10),
          child: FutureBuilder(
              future: Provider.of<CompetencyProvider>(context, listen: false)
                  .getCompetencys(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Consumer<CompetencyProvider>(
                    builder: (context, data, _) {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: (itemWidth / itemHeight),
                          crossAxisCount: 2,
                        ),
                        itemCount: data.dataCompetencys.length,
                        itemBuilder: (_, i) => InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailCompetency()));
                          },
                          child: ChildCompetency(
                              data.dataCompetencys[i].id,
                              data.dataCompetencys[i].image,
                              data.dataCompetencys[i].name),
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

class ChildCompetency extends StatelessWidget {
  int id = 0;
  String image = "", name = "";

  ChildCompetency(this.id, this.image, this.name) {}

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
                    ? Image.asset("assets/icons/ic_competency.png",
                        height: 50, width: 50, fit: BoxFit.cover)
                    : Image.network(
                        "https://humancapitalpriokpomu.com/" + image,
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover)),
            SizedBox(
              height: 10,
            ),
            Text(
              name,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.left,
            )
          ],
        ),
      ),
    );
  }
}
