import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sdm_priok/features/competency/view_detail_competency.dart';
import 'package:sdm_priok/features/competency/view_sub_category_competency.dart';
import 'package:sdm_priok/provider/competency_provider.dart';

import '../../helpers/colours.dart';

class ListCategoryCompetency extends StatefulWidget {
  final String category;
  const ListCategoryCompetency({Key? key, required this.category}) : super(key: key);

  @override
  State<ListCategoryCompetency> createState() => _ListCategoryCompetencyState();
}

class _ListCategoryCompetencyState extends State<ListCategoryCompetency> {
  @override
  Widget build(BuildContext context) {
    print("Category : " + widget.category);
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 10;
    final double itemWidth = size.width;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Category Competencies"),
        backgroundColor: ColorPrimary,
      ),
      backgroundColor: ColorWhite,
      body: RefreshIndicator(
        onRefresh: () => Provider.of<CompetencyProvider>(context, listen: false).getCategoryCompetencys(widget.category),
        color: ColorPrimary,
        child: Container(
          margin: EdgeInsets.all(10),
          child: FutureBuilder(
              future: Provider.of<CompetencyProvider>(context, listen: false).getCategoryCompetencys(widget.category),
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
                          crossAxisCount: 1,
                        ),
                        itemCount: data.dataCategory.length,
                        itemBuilder: (_, i) => InkWell(
                          onTap: () {
                            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailCompetency()));
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListSubCategoryCompetency(subcategory: data.dataCategory[i].category)));
                          },
                          child: ChildCategory(i + 1, data.dataCategory[i].category),
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

class ChildCategory extends StatelessWidget {
  int number = 0;
  String name = "";

  ChildCategory(this.number, this.name) {}

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
        child: Row(
          children: [
            Text(
              number.toString(),
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              width: 10,
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
