import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';
import 'package:piehme_cup_flutter/routes/route_generator.dart';
import 'package:piehme_cup_flutter/screens/login.dart';

void main() {
  runApp(const PiehmeCup());
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
    );
  }
}
