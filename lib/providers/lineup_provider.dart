import 'package:piehme_cup_flutter/models/player.dart';
import 'package:piehme_cup_flutter/models/user.dart';
import 'package:piehme_cup_flutter/providers/base_lineup_provider.dart';
import 'package:piehme_cup_flutter/services/leaderboard_service.dart';
import 'package:piehme_cup_flutter/services/players_service.dart';
import 'package:piehme_cup_flutter/services/users_service.dart';

class LineupProvider extends BaseLineupProvider {

  late List<Player> _lineup = <Player>[];
  late int _avgRating = 0;
  late int _lineupRating = 0;
  late int _maxRating = 0;
  late User _user = User.empty();

  @override
  List<Player> get lineup => _lineup;
  @override
  int get avgRating => _avgRating;
  @override
  int get lineupRating => _lineupRating;
  @override
  int get maxRating => _maxRating;
  @override
  User get user => _user;

  @override
  Future<void> loadLineup(int userId) async {
    _lineup = [];
    _avgRating = 0;
    _maxRating = 0;
    _lineupRating = 0;
    List<int> stats = await LeaderboardService.getStats();
    _lineup = await PlayersService.getLineup();
    _user = await UsersService.getUserIcon();
    resetAddedCards();
    _avgRating = stats[0];
    _maxRating = stats[1];
    _lineupRating = _user.lineupRating.round();
    notifyListeners();
  }

}