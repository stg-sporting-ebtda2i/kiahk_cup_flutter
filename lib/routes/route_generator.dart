import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/screens/maintenance_screen.dart';
import 'package:piehme_cup_flutter/screens/players_store.dart';
import 'package:piehme_cup_flutter/screens/positions_store.dart';
import 'package:piehme_cup_flutter/screens/rating_store.dart';
import 'package:piehme_cup_flutter/screens/icons_store.dart';
import 'package:piehme_cup_flutter/screens/lineup.dart';
import 'package:piehme_cup_flutter/screens/register.dart';
import 'package:piehme_cup_flutter/screens/solve_quiz.dart';
import 'package:piehme_cup_flutter/screens/splash_screen.dart';
import 'app_routes.dart';
import 'package:piehme_cup_flutter/screens/login.dart';
import 'package:piehme_cup_flutter/screens/home.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case AppRoutes.cardsStore:
        return MaterialPageRoute(builder: (_) => IconsStorePage());
      case AppRoutes.playersStore:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
            builder: (_) => PlayersStorePage(position: args?['position'],),
        );
      case AppRoutes.lineup:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => LineupPage(userLineup: args?['userLineup'], userId: args?['userId'],),
        );
      case AppRoutes.positionsStore:
        return MaterialPageRoute(builder: (_) => PositionsStorePage());
      case AppRoutes.ratingStore:
        return MaterialPageRoute(builder: (_) => RatingStorePage());
      case AppRoutes.quiz:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => QuizPage(quizSlug: args?['quizSlug']),
        );
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case AppRoutes.maintenance:
        return MaterialPageRoute(builder: (_) => MaintenancePage());
      default:
      // Handle unknown routes
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}