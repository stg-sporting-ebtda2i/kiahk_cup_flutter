import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';
import 'package:piehme_cup_flutter/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<void> _checkIfLoggedIn() async {
    String page;
    if (await AuthService.hasToken()) {
      page = AppRoutes.home;
    } else {
      page = AppRoutes.login;
    }
    Future.delayed(Duration(seconds: 10), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, page);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000c24),
      body: Center(
        child: SizedBox(
          height: 180,
            width: 180,
            child: Image.asset('assets/splash_logo.png')),
      ),
    );
  }
}