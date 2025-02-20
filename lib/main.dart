import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:piehme_cup_flutter/providers/attendance_provider.dart';
import 'package:piehme_cup_flutter/providers/buttons_visibility_provider.dart';
import 'package:piehme_cup_flutter/providers/header_provider.dart';
import 'package:piehme_cup_flutter/providers/icons_store_provider.dart';
import 'package:piehme_cup_flutter/providers/leaderboard_provider.dart';
import 'package:piehme_cup_flutter/providers/lineup_provider.dart';
import 'package:piehme_cup_flutter/providers/players_store_provider.dart';
import 'package:piehme_cup_flutter/providers/positions_store_provider.dart';
import 'package:piehme_cup_flutter/providers/quizzes_provider.dart';
import 'package:piehme_cup_flutter/providers/rating_store_provider.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';
import 'package:piehme_cup_flutter/routes/route_generator.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
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
          ChangeNotifierProvider(create: (_) => RatingStoreProvider()),
          ChangeNotifierProvider(create: (_) => LeaderboardProvider()),
          ChangeNotifierProvider(create: (_) => AttendanceProvider()),
          ChangeNotifierProvider(create: (_) => ButtonsVisibilityProvider()),
          ChangeNotifierProvider(create: (_) => QuizzesProvider()),
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: RouteGenerator.generateRoute,
      builder: EasyLoading.init(),
    );
  }
}
