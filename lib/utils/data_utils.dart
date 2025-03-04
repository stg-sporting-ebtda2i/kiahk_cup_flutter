import 'package:flutter/cupertino.dart';
import 'package:piehme_cup_flutter/providers/attendance_provider.dart';
import 'package:piehme_cup_flutter/providers/buttons_visibility_provider.dart';
import 'package:piehme_cup_flutter/providers/header_provider.dart';
import 'package:piehme_cup_flutter/providers/icons_store_provider.dart';
import 'package:piehme_cup_flutter/providers/leaderboard_provider.dart';
import 'package:piehme_cup_flutter/providers/lineup_provider.dart';
import 'package:piehme_cup_flutter/providers/positions_store_provider.dart';
import 'package:piehme_cup_flutter/providers/quizzes_provider.dart';
import 'package:piehme_cup_flutter/providers/rating_store_provider.dart';
import 'package:piehme_cup_flutter/providers/user_provider.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';
import 'package:provider/provider.dart';

class DataUtils {

  static Future<void> initApp(BuildContext context) async {
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

    await buttonsVisibilityProvider.refreshData();

    if (buttonsVisibilityProvider.isVisible('Maintenance') && context.mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.maintenance);
      return;
    }

    await attendanceProvider.loadLiturgies();
    await headerProvider.initialize();
    await iconsStoreProvider.loadStore();
    await leaderboardProvider.loadLeaderboard();
    await lineupProvider.loadLineup(-1);
    await positionsStoreProvider.loadStore();
    await quizzesProvider.loadQuizzes();
    await ratingStoreProvider.loadData();
    await userProvider.loadUserData();

  }

}