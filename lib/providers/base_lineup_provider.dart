import 'package:flutter/cupertino.dart';
import 'package:piehme_cup_flutter/models/player.dart';
import 'package:piehme_cup_flutter/models/user.dart';

abstract class BaseLineupProvider with ChangeNotifier {

  final Set<int> _usedPlayerIds = {};
  final Set<int> _checkedPlayerIds = {};
  late bool userCardUsed = false;
  late bool userCardChecked = false;

  List<Player> get lineup;
  int get avgRating;
  int get lineupRating;
  int get maxRating;
  User get user;
  Future<void> loadLineup(int userId);
  void refreshListeners();

  void resetAddedCards() {
    _usedPlayerIds.clear();
    userCardUsed = false;
    _checkedPlayerIds.clear();
    userCardChecked = false;
  }

  bool isUsed(Player player) {
    return _usedPlayerIds.contains(player.id);
  }

  void use(Player player) {
    _usedPlayerIds.add(player.id);
  }

  Player? getNextPlayer(String position) {
    final availablePlayers = lineup
        .where((player) => player.position == position && !isUsed(player))
        .toList();

    if (availablePlayers.isNotEmpty) {
      use(availablePlayers.first);
      return availablePlayers.first;
    }
    return null;
  }

  String checkChangedData(String position) {
    final availablePlayers = lineup
        .where((player) => player.position == position && !isUsed(player))
        .toList();
    if (position == user.position) {
      userCardChecked = true;
      return user.name;
    } else if (availablePlayers.isNotEmpty) {
      _checkedPlayerIds.add(availablePlayers.first.id);
      return availablePlayers.first.name;
    } else {
      return 'Null';
    }
  }

}