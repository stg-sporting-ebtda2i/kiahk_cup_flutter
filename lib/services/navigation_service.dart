import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  // static BuildContext? get context => navigatorKey.currentContext;

  static void logoutAndRedirect() {
    if (navigatorKey.currentContext != null) {
      Navigator.of(
        navigatorKey.currentContext!,
      ).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
    }
  }

  static Future<void> loginAndRedirect() async {
    if (navigatorKey.currentContext != null) {
      try {
        // await navigatorKey.currentContext!
        //     .read<DeaconsProvider>()
        //     .loadDeaconRanks();
        // await navigatorKey.currentContext!.read<DeaconsProvider>().loadSkills();
        // await navigatorKey.currentContext!.read<DeaconsProvider>().loadDeacons(
        //   reset: true,
        // );
        // await navigatorKey.currentContext!
        //     .read<AttendanceProvider>()
        //     .loadLiturgies();
      } catch (e) {
        print('Error: ${e.toString()}');
        // showErrorDialog(navigatorKey.currentContext!, e.toString());
      }
      Navigator.of(
        navigatorKey.currentContext!,
      ).pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
    }
  }
}