import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';
import 'package:piehme_cup_flutter/routes/route_generator.dart';
import 'package:piehme_cup_flutter/screens/login.dart';

void main() {
  runApp(const PiehmeCup());
  EasyLoading.instance
    ..loadingStyle =EasyLoadingStyle.custom
    ..indicatorType = EasyLoadingIndicatorType.squareCircle
    ..indicatorColor = Colors.black
    ..textColor = Colors.black
    ..backgroundColor = Colors.greenAccent
    ..textStyle = TextStyle(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 18)
    ..indicatorSize = 70
    ..radius = 10.0
    ..userInteractions = false;
}

class PiehmeCup extends StatelessWidget {
  const PiehmeCup({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      initialRoute: AppRoutes.login,
      onGenerateRoute: RouteGenerator.generateRoute,
      builder: EasyLoading.init(),
    );
  }
}
