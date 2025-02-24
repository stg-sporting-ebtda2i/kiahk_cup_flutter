import 'package:flutter/cupertino.dart';
import 'package:piehme_cup_flutter/dialogs/loading.dart';
import 'package:piehme_cup_flutter/models/player.dart';
import 'package:piehme_cup_flutter/models/user.dart';
import 'package:piehme_cup_flutter/services/leaderboard_service.dart';
import 'package:piehme_cup_flutter/services/players_service.dart';
import 'package:piehme_cup_flutter/services/users_service.dart';

class LineupProvider with ChangeNotifier {

  late List<Player> _lineup = <Player>[];
  late int _avgRating = 0;
  late int _lineupRating = 0;
  late int _maxRating = 0;
  final Set<int> _usedPlayerIds = {};
  late bool userCardUsed = false;
  late User _user = User(
    id: -1,
    name: 'Loading',
    cardRating: 0,
    imageUrl: null,
    imageKey: null,
    lineupRating: 0,
    iconUrl: '',
    iconKey: '',
    position: ''
  );

  List<Player> get lineup => _lineup;
  int get avgRating => _avgRating;
  int get lineupRating => _lineupRating;
  int get maxRating => _maxRating;
  User get user => _user;

  void loadUserData() async {
    _lineup = [];

    await Loading.show(() async {
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
    });
  }

  void loadOtherUserData(int userId) async {
    _lineup = [];

    await Loading.show(() async {
      _avgRating = 0;
      _maxRating = 0;
      _lineupRating = 0;
      List<int> stats = await LeaderboardService.getStats();
      _lineup = await PlayersService.getLineupById(userId);
      _user = await UsersService.getOtherUserIcon(userId);
      resetAddedCards();
      _avgRating = stats[0];
      _maxRating = stats[1];
      _lineupRating = _user.lineupRating.round();
      notifyListeners();
    }, message: 'Loading Lineup...', delay: Duration.zero);
  }

  void resetAddedCards() {
    _usedPlayerIds.clear();
    userCardUsed = false;
    notifyListeners();
  }

  bool isUsed(Player player) {
    return _usedPlayerIds.contains(player.id);
  }

  void use(Player player) {
    _usedPlayerIds.add(player.id);
  }

  Player? getNextPlayer(String position) {
    final availablePlayers = _lineup
        .where((player) => player.position == position && !isUsed(player))
        .toList();

    if (availablePlayers.isNotEmpty) {
      use(availablePlayers.first);
      return availablePlayers.first;
    }
    return null;
  }

}