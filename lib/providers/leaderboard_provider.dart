import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:piehme_cup_flutter/dialogs/toast_error.dart';
import 'package:piehme_cup_flutter/models/user.dart';
import 'package:piehme_cup_flutter/services/leaderboard_service.dart';

class LeaderboardProvider with ChangeNotifier {

  List<User> _leaderboard = <User>[];

  List<User> get leaderboard => _leaderboard;

  void loadLineup() async {
    EasyLoading.show(status: 'Loading...');
    try {
      _leaderboard = await LeaderboardService.getLeaderboard();
    } catch (e) {
      toastError(e.toString());
    } finally {
      EasyLoading.dismiss(animation: true);
      notifyListeners();
    }
  }

}