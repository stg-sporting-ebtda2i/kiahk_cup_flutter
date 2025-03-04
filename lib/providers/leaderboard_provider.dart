import 'package:flutter/cupertino.dart';
import 'package:piehme_cup_flutter/models/user.dart';
import 'package:piehme_cup_flutter/services/leaderboard_service.dart';

class LeaderboardProvider with ChangeNotifier {

  List<User> _leaderboard = <User>[];

  List<User> get leaderboard => _leaderboard;

  Future<void> loadLeaderboard() async {
    _leaderboard = await LeaderboardService.getLeaderboard();
    notifyListeners();
  }

}