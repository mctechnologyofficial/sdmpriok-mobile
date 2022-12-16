import 'dart:async';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sdm_priok/features/chart/view_chart.dart';
import 'package:sdm_priok/features/mentoring/view_mentoring.dart';
import 'package:sdm_priok/features/utilities/view_utilities.dart';
import 'package:sdm_priok/helpers/colours.dart';
import 'package:sdm_priok/provider/slider_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../dialogs/dialog_menu.dart';
import '../../helpers/data_helper.dart';
import '../employee/view_employee.dart';

final List<String> imgList = [
  'assets/images/img_banner1.jpg',
  'assets/images/img_banner4.png',
  'assets/images/img_banner2.jpg',
  'assets/images/img_banner5.png',
  'assets/images/img_banner3.jpg'
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            height: 250,
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: ColorWhite),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20), // Image border
              child: SizedBox.fromSize(
                child: Image.asset(
                  item,
                  fit: BoxFit.cover,
                  height: 250,
                  width: 1000,
                ),
              ),
            ),
          ),
        ))
    .toList();
    
class HomeAdminPage extends StatefulWidget {
  static String TagHome = "HomePage";

  @override
  State<HomeAdminPage> createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<HomeAdminPage> {
  SharedPreferences? sharedPref;
  DataHelper dataHelper = new DataHelper();
  String profilePicture = "";

  @override
  void initState() {
    super.initState();
    initializePreference().whenComplete(() {
      setState(() {});
    });
  }

  Future<void> initializePreference() async {
    this.sharedPref = await SharedPreferences.getInstance();
    profilePicture = this.sharedPref?.getString("Pict") as String;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSecondWhite,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorWhite),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              // Image border
                              child: SizedBox.fromSize(
                                // size: Size.fromRadius(40), // Image radius
                                child: profilePicture.isEmpty
                                    ? Image.asset(
                                    "assets/icons/ic_avatar.png",
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover)
                                    : Image.network(
                                    dataHelper.BaseURL + profilePicture,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${this.sharedPref?.getString("Name")}",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Admin",
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                      color: ColorGrey),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                              onTap: () {
                                BottomDialog().showBottomDialog(context);
                              },
                              child: SvgPicture.asset(
                                  "assets/icons/ic_setting.svg",
                                  semanticsLabel: 'Setting')),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // ComplicatedImageDemo(),
                FutureBuilder(
                    future: Provider.of<SliderProvider>(context, listen: false).getSliders(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return Consumer<SliderProvider>(
                          builder: (context, data, _) {
                            return CarouselSlider(
                              options: CarouselOptions(
                                autoPlay: true,
                                aspectRatio: 2.0,
                                enlargeCenterPage: true,
                              ),
                              items: data.dataSlider.map((value) {
                                return Container(
                                  child: Container(
                                    height: 250,
                                    margin: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: ColorWhite),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          20), // Image border
                                      child: SizedBox.fromSize(
                                        child: Image.network(
                                          "https://humancapitalpriokpomu.com/" +
                                              value.image,
                                          fit: BoxFit.cover,
                                          height: 250,
                                          width: 1000,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        );
                      }
                    }),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Menu",
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorBlack),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Features(1, "assets/icons/ic_team.png", "Employees"),
                        Features(
                            2, "assets/icons/ic_monitoring.png", "Mentoring"),
                        Features(3, "assets/icons/ic_chart.png", "Chart"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Features(
                            4, "assets/icons/ic_utilities.png", "Utilities"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Features extends StatelessWidget {
  int id;
  String image;
  String title;

  Features(this.id, this.image, this.title) {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (id == 1) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Employee()));
        } else if (id == 2) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Mentoring()));
        } else if (id == 3) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Chart()));
        } else if (id == 4) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Utilities()));
        }
      },
      child: Card(
        margin: EdgeInsets.only(left: 5, right: 5, bottom: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 2,
        child: Container(
          width: 90,
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Image.asset(
                image,
                width: 50,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                title,
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: ColorGrey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class ComplicatedImageDemo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future:
//             Provider.of<SliderProvider>(context, listen: false).getSliders(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else {
//             return Consumer<SliderProvider>(
//               builder: (context, data, _) {
//                 return CarouselSlider(
//                   options: CarouselOptions(
//                     autoPlay: true,
//                     aspectRatio: 2.0,
//                     enlargeCenterPage: true,
//                   ),
//                   items: data.dataSlider.map((value) {
//                     return Container(
//                       child: Container(
//                         height: 250,
//                         margin: EdgeInsets.all(5.0),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             color: ColorWhite),
//                         child: ClipRRect(
//                           borderRadius:
//                               BorderRadius.circular(20), // Image border
//                           child: SizedBox.fromSize(
//                             child: Image.network(
//                               "https://humancapitalpriokpomu.com/"+value.image,
//                               fit: BoxFit.cover,
//                               height: 250,
//                               width: 1000,
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 );
//               },
//             );
//           }
//         });
//   }
// }
