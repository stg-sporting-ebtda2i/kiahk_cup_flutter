import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/screens/change_picture.dart';
import 'package:piehme_cup_flutter/screens/positions_store.dart';
import 'package:piehme_cup_flutter/screens/rating_store.dart';
import 'package:piehme_cup_flutter/screens/icons_store.dart';
import 'package:piehme_cup_flutter/screens/lineup.dart';
import 'package:piehme_cup_flutter/screens/solve_quiz.dart';
import 'app_routes.dart';
import 'package:piehme_cup_flutter/screens/login.dart';
import 'package:piehme_cup_flutter/screens/home.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case AppRoutes.cardsStore:
        return MaterialPageRoute(builder: (_) => StorePage());
      case AppRoutes.lineup:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => LineupPage(userLineup: args?['userLineup']),
        );
      case AppRoutes.positionsStore:
        return MaterialPageRoute(builder: (_) => PositionsStorePage());
      case AppRoutes.ratingStore:
        return MaterialPageRoute(builder: (_) => RatingStorePage());
      case AppRoutes.quiz:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => QuizPage(quizID: args?['quizID']),
        );
      case AppRoutes.changePicture:
        return MaterialPageRoute(builder: (_) => ChangePicturePage());
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