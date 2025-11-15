import 'package:flutter/cupertino.dart';
import 'package:piehme_cup_flutter/dialogs/message.dart';
import 'package:piehme_cup_flutter/models/user.dart';
import 'package:piehme_cup_flutter/providers/attendance_provider.dart';
import 'package:piehme_cup_flutter/providers/buttons_visibility_provider.dart';
import 'package:piehme_cup_flutter/providers/header_provider.dart';
import 'package:piehme_cup_flutter/providers/icons_store_provider.dart';
import 'package:piehme_cup_flutter/providers/icons_text_color_provider.dart';
import 'package:piehme_cup_flutter/providers/leaderboard_provider.dart';
import 'package:piehme_cup_flutter/providers/lineup_provider.dart';
import 'package:piehme_cup_flutter/providers/positions_store_provider.dart';
import 'package:piehme_cup_flutter/providers/quizzes_provider.dart';
import 'package:piehme_cup_flutter/providers/rating_store_provider.dart';
import 'package:piehme_cup_flutter/providers/user_provider.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';
import 'package:provider/provider.dart';

class DataUtils {

  static Future<void> initApp(BuildContext context, String page) async {
    final attendanceProvider = context.read<AttendanceProvider>();
    final buttonsVisibilityProvider = context.read<ButtonsVisibilityProvider>();
    final headerProvider = context.read<HeaderProvider>();
    final iconsStoreProvider = context.read<IconsStoreProvider>();
    final leaderboardProvider = context.read<LeaderboardProvider>();
    final lineupProvider = context.read<LineupProvider>();
    final positionsStoreProvider = context.read<PositionsStoreProvider>();
    final quizzesProvider = context.read<QuizzesProvider>();
    final ratingStoreProvider = context.read<RatingStoreProvider>();
    final userProvider = context.read<UserProvider>();
    final iconsTextColorProvider = context.read<IconsTextColorProvider>();

    try {
      await buttonsVisibilityProvider.refreshData();

      if (buttonsVisibilityProvider.isVisible('Maintenance') && context.mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.maintenance);
        return;
      }

      await Future.wait([
        attendanceProvider.loadLiturgies(),
        attendanceProvider.loadRequestedAttendances(),
        headerProvider.initialize(),
        iconsStoreProvider.loadStore(),
        leaderboardProvider.loadLeaderboard(),
        lineupProvider.loadLineup(-1),
        positionsStoreProvider.loadStore(),
        quizzesProvider.loadQuizzes(),
        ratingStoreProvider.loadData(),
        userProvider.loadUserData(),
        iconsTextColorProvider.loadAllCachedColors(),
      ]);

      List<String> checkedKeys = <String>[];
      for (User user in leaderboardProvider.leaderboard) {
        if (checkedKeys.contains(user.iconKey)) continue;
        await iconsTextColorProvider.getTextColor(key: user.iconKey, url: user.iconUrl);
        if (user.iconKey != null) checkedKeys.add(user.iconKey!);
      }

      if (context.mounted) {
        Navigator.pushReplacementNamed(context, page);
      }

    } catch (e) {
      print("ASD -> $e");
      toast(e.toString());
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    }

  }

}