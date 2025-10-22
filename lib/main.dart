import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:piehme_cup_flutter/constants/app_colors.dart';
import 'package:piehme_cup_flutter/providers/attendance_provider.dart';
import 'package:piehme_cup_flutter/providers/buttons_visibility_provider.dart';
import 'package:piehme_cup_flutter/providers/header_provider.dart';
import 'package:piehme_cup_flutter/providers/icons_store_provider.dart';
import 'package:piehme_cup_flutter/providers/icons_text_color_provider.dart';
import 'package:piehme_cup_flutter/providers/leaderboard_provider.dart';
import 'package:piehme_cup_flutter/providers/lineup_provider.dart';
import 'package:piehme_cup_flutter/providers/other_lineup_provider.dart';
import 'package:piehme_cup_flutter/providers/players_store_provider.dart';
import 'package:piehme_cup_flutter/providers/positions_store_provider.dart';
import 'package:piehme_cup_flutter/providers/quizzes_provider.dart';
import 'package:piehme_cup_flutter/providers/rating_store_provider.dart';
import 'package:piehme_cup_flutter/providers/user_provider.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';
import 'package:piehme_cup_flutter/routes/route_generator.dart';
import 'package:piehme_cup_flutter/services/navigation_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HeaderProvider()),
          ChangeNotifierProvider(create: (_) => IconsStoreProvider()),
          ChangeNotifierProvider(create: (_) => PlayersStoreProvider()),
          ChangeNotifierProvider(create: (_) => PositionsStoreProvider()),
          ChangeNotifierProvider(create: (_) => LineupProvider()),
          ChangeNotifierProvider(create: (_) => OtherLineupProvider()),
          ChangeNotifierProvider(create: (_) => RatingStoreProvider()),
          ChangeNotifierProvider(create: (_) => LeaderboardProvider()),
          ChangeNotifierProvider(create: (_) => AttendanceProvider()),
          ChangeNotifierProvider(create: (_) => ButtonsVisibilityProvider()),
          ChangeNotifierProvider(create: (_) => QuizzesProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => IconsTextColorProvider()),
        ],
      child: const PiehmeCup(),
    ),
  );
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: true,
      navigatorKey: NavigationService.navigatorKey,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.brand, brightness: Brightness.light,),
        useMaterial3: true,
      ),
      builder: EasyLoading.init(),
    );
  }
}
