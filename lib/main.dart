import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:sdm_priok/features/view_splash_screen.dart';
import 'package:sdm_priok/provider/auth_provider.dart';
import 'package:sdm_priok/provider/employee_provider.dart';
import 'package:sdm_priok/provider/role_provider.dart';
import 'package:sdm_priok/provider/slider_provider.dart';
import 'package:sdm_priok/provider/team_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => EmployeeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => RoleProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TeamProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SliderProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: Employee(),
        home: SplashScreenPage(),
        builder: EasyLoading.init(),
      ),
    );
  }
}

// void configLoading() {
//   EasyLoading.instance
//     ..displayDuration = const Duration(milliseconds: 2000)
//     ..indicatorType = EasyLoadingIndicatorType.fadingCircle
//     ..loadingStyle = EasyLoadingStyle.dark
//     ..indicatorSize = 45.0
//     ..radius = 10.0
//     ..progressColor = Colors.yellow
//     ..backgroundColor = Colors.green
//     ..indicatorColor = Colors.yellow
//     ..textColor = Colors.yellow
//     ..maskColor = Colors.blue.withOpacity(0.5)
//     ..userInteractions = true
//     ..dismissOnTap = false
//     ..customAnimation = CustomAnimation();
// }