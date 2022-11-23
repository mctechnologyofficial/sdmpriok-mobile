import 'package:flutter/material.dart';

import '../../helpers/colours.dart';

class Mentoring extends StatelessWidget {
  const Mentoring({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mentoring"),
        backgroundColor: ColorPrimary,
      ),
      backgroundColor: ColorWhite,
      body: SingleChildScrollView(
        child: Column(

        ),
      ),
    );
  }
}
