import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/store.dart';
import 'package:piehme_cup_flutter/widgets/lineup_full_widget.dart';
import 'app_routes.dart';
import 'package:piehme_cup_flutter/screens/login.dart';
import 'package:piehme_cup_flutter/screens/home.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const Home());
      case AppRoutes.cards_store:
        return MaterialPageRoute(builder: (_) => StorePage());
      case AppRoutes.lineup:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => LineupPage(userLineup: args?['userLineup']),
        );
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