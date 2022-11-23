import 'package:flutter/material.dart';

import '../../helpers/colours.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chart"),
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
