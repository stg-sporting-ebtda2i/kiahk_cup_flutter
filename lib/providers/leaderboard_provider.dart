import 'package:flutter/cupertino.dart';
import 'package:piehme_cup_flutter/models/user.dart';
import 'package:piehme_cup_flutter/services/leaderboard_service.dart';

class LeaderboardProvider with ChangeNotifier {

  List<User> _leaderboard = <User>[];
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<User> get leaderboard => _leaderboard;

  Future<void> loadLeaderboard() async {
    _isLoading = true;
    notifyListeners();
    _leaderboard = await LeaderboardService.getLeaderboard();
    _isLoading = false;
    notifyListeners();
  }

}