import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';
import 'package:piehme_cup_flutter/services/auth_service.dart';
import 'package:piehme_cup_flutter/utils/data_utils.dart';
import 'package:piehme_cup_flutter/utils/splash_utils.dart';

class SplashTheme {
  final Color start;
  final Color end;
  final String imgPath;

  SplashTheme({
    required this.start,
    required this.end,
    required this.imgPath,
  });
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  Future<void> _checkIfLoggedIn() async {
    String? token = await AuthService.getToken();
    bool isLoggedIn = token != null;

    if (mounted && isLoggedIn) {
      await DataUtils.initApp(context, AppRoutes.home);
    } else if (mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    SplashTheme theme = SplashUtils.getTheme();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [theme.start, theme.end],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
          ),
        ),
        child: Center(
          child: SizedBox(
            height: 180,
            width: 180,
            child: Image.asset(theme.imgPath), // Ensure the image path is correct
          ),
        ),
      ),
    );
  }
}