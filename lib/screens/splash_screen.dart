import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/providers/buttons_visibility_provider.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';
import 'package:piehme_cup_flutter/services/auth_service.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<void> _checkIfLoggedIn() async {
    String page;
    String? token = await AuthService.getToken();
    bool isLoggedIn = token != null;
    page = isLoggedIn ? AppRoutes.home : AppRoutes.login;

    if (mounted && isLoggedIn) {
      ButtonsVisibilityProvider provider = context.read<ButtonsVisibilityProvider>();
      await provider.refreshData();
      if (provider.isVisible('Maintenance')) {
        page = AppRoutes.maintenance;
      }
    }
    Future.delayed(Duration(seconds: 1), () {
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