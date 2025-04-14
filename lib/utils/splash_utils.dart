import 'dart:ui';

import 'package:piehme_cup_flutter/screens/splash_screen.dart';

class SplashUtils {

  /// Checks if current time (with hours/minutes/seconds) is between [start] and [end]
  static bool isNowBetween({
    required DateTime start,
    required DateTime end,
    bool inclusive = true,
  }) {
    final now = DateTime.now();

    if (start.isAfter(end)) {
      // Handle overnight ranges (e.g., 10 PM to 2 AM)
      return inclusive
          ? (now.isAfter(start) || now.isAtSameMomentAs(start)) ||
          (now.isBefore(end) || now.isAtSameMomentAs(end))
          : now.isAfter(start) || now.isBefore(end);
    }

    return inclusive
        ? (now.isAfter(start) || now.isAtSameMomentAs(start)) &&
        (now.isBefore(end) || now.isAtSameMomentAs(end))
        : now.isAfter(start) && now.isBefore(end);
  }

  static SplashTheme getTheme() {
    if (isNowBetween(start: DateTime(2025, 1, 1, 0, 0, 0), end: DateTime(2025, 4, 13, 18, 0))) {
      // Normal
      return SplashTheme(
          start: Color(0xFFfee396),
          end: Color(0xFFb6783d),
          imgPath: 'assets/splash_logo.png'
      );
    } else if (isNowBetween(start: DateTime(2025, 4, 13, 18, 0), end: DateTime(2025, 4, 14, 18, 0))) {
      // Monday
      return SplashTheme(
          start: Color(0xFF000000),
          end: Color(0xFF403e3e),
          imgPath: 'assets/monday_icon.png'
      );
    } else if (isNowBetween(start: DateTime(2025, 4, 14, 18, 0), end: DateTime(2025, 4, 15, 18, 0))) {
      // Tuesday
      return SplashTheme(
          start: Color(0xFF000000),
          end: Color(0xFF403e3e),
          imgPath: 'assets/tuesday_icon.png'
      );
    } else if (isNowBetween(start: DateTime(2025, 4, 15, 18, 0), end: DateTime(2025, 4, 16, 18, 0))) {
      // Wednesday
      return SplashTheme(
          start: Color(0xFF000000),
          end: Color(0xFF403e3e),
          imgPath: 'assets/wednesday_icon.png'
      );
    } else if (isNowBetween(start: DateTime(2025, 4, 16, 18, 0), end: DateTime(2025, 4, 17, 18, 0))) {
      // Thursday
      return SplashTheme(
          start: Color(0xFF000000),
          end: Color(0xFF403e3e),
          imgPath: 'assets/thursday_icon.png'
      );
    } else if (isNowBetween(start: DateTime(2025, 4, 17, 18, 0), end: DateTime(2025, 4, 18, 21, 0))) {
      // Friday
      return SplashTheme(
          start: Color(0xFF000000),
          end: Color(0xFF403e3e),
          imgPath: 'assets/friday_icon.png'
      );
    } else if (isNowBetween(start: DateTime(2025, 4, 18, 21, 0), end: DateTime(2025, 4, 19, 23, 59))) {
      // Abo 8alamsis
      return SplashTheme(
          start: Color(0xFF740000),
          end: Color(0xFFff0000),
          imgPath: 'assets/abo_8alamsis_icon.png'
      );
    } else if (isNowBetween(start: DateTime(2025, 4, 19, 23, 59), end: DateTime(2025, 4, 20, 23, 59))) {
      // Eyama
      return SplashTheme(
          start: Color(0xFFe8e0c3),
          end: Color(0xFFffffff),
          imgPath: 'assets/eyama_icon.png'
      );
    } else {
      // khamasin
      return SplashTheme(
          start: Color(0xFFe8e0c3),
          end: Color(0xFFffffff),
          imgPath: 'assets/khamasin_icon.png'
      );
    }
  }

}