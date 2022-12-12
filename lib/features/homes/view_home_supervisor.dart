import 'dart:async';
import 'dart:ffi';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sdm_priok/features/competency/view_list_competency.dart';
import 'package:sdm_priok/features/employee/view_list_employee.dart';
import 'package:sdm_priok/helpers/colours.dart';
import 'package:sdm_priok/helpers/strings.dart';
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

class HomeSupervisorPage extends StatefulWidget {
  static String TagHome = "HomePage";

  @override
  State<HomeSupervisorPage> createState() => _HomeSupervisorPageState();
}

class _HomeSupervisorPageState extends State<HomeSupervisorPage> {
  SharedPreferences? sharedPref;
  DataHelper dataHelper = new DataHelper();
  double percent = 0.0;

  @override
  void initState() {
    super.initState();
    Timer? timer;
    timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      setState(() {
        percent += 1;
        if (percent >= 80) {
          timer?.cancel();
          // percent=0;
        }
      });
    });
    initializePreference().whenComplete(() {
      setState(() {});
    });
  }

  Future<void> initializePreference() async {
    this.sharedPref = await SharedPreferences.getInstance();
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
                        Container(
                          width: 250,
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                // Image border
                                child: SizedBox.fromSize(
                                  // size: Size.fromRadius(40), // Image radius
                                  child: Image.network(
                                      "https://awsimages.detik.net.id/community/media/visual/2022/01/12/ardhito-pramono-10_169.jpeg?w=1200",
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Column(
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
                                      "Supervisor",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300,
                                          color: ColorGrey),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
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
                    future: Provider.of<SliderProvider>(context, listen: false)
                        .getSliders(),
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
                        Features(1, "assets/icons/ic_monitoring.png", "Mentoring"),
                        Features(2, "assets/icons/ic_exam.png", "Tools"),
                        Features(3, "assets/icons/ic_graph.png", "Chart"),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Competency Progress",
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorBlack),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Personal",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: ColorBlack),
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: LiquidLinearProgressIndicator(
                          value: percent / 100,
                          valueColor: AlwaysStoppedAnimation(ColorPrimary),
                          backgroundColor: Colors.white,
                          borderColor: ColorPrimary,
                          borderWidth: 1,
                          borderRadius: 15,
                          direction: Axis.horizontal,
                          center: Text(
                            percent.toString() + "%",
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: ColorWhitePrimary),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Team",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: ColorBlack),
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: LiquidLinearProgressIndicator(
                          value: percent / 100,
                          valueColor: AlwaysStoppedAnimation(ColorPrimary),
                          backgroundColor: Colors.white,
                          borderColor: ColorPrimary,
                          borderWidth: 1,
                          borderRadius: 15,
                          direction: Axis.horizontal,
                          center: Text(
                            percent.toString() + "%",
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: ColorWhitePrimary),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // News(),
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

  Features(this.id, this.image, this.title) {

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (id == 1) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListEmployee()));
        }else if(id == 2){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListCompetency()));
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
                textAlign: TextAlign.center,
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

class ComplicatedImageDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
      items: imageSliders,
    );
  }
}
