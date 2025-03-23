import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';
import 'package:piehme_cup_flutter/services/auth_service.dart';
import 'package:piehme_cup_flutter/utils/data_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  Future<void> _checkIfLoggedIn() async {
    String page;
    String? token = await AuthService.getToken();
    bool isLoggedIn = token != null;
    page = isLoggedIn ? AppRoutes.home : AppRoutes.login;

    if (mounted && isLoggedIn) {
      await DataUtils.initApp(context, page);
    }
  }

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFfee396), Color(0xFFb6783d)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
          ),
        ),
        child: Center(
          child: SizedBox(
            height: 180,
            width: 180,
            child: Image.asset('assets/splash_logo.png'), // Ensure the image path is correct
          ),
        ),
      ),
    );
  }
}