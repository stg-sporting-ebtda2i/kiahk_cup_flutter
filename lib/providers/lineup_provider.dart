import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:piehme_cup_flutter/dialogs/toast_error.dart';
import 'package:piehme_cup_flutter/models/player.dart';
import 'package:piehme_cup_flutter/models/user.dart';
import 'package:piehme_cup_flutter/services/players_service.dart';
import 'package:piehme_cup_flutter/services/users_service.dart';

class LineupProvider with ChangeNotifier {

  late List<Player> _lineup = <Player>[];
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
  User get user => _user;

  void loadLineup() async {
    EasyLoading.show(status: 'Loading...');
    try {
      _lineup = await PlayersService.getLineup();
      resetAddedCards();
    } catch (e) {
      toastError(e.toString());
    } finally {
      EasyLoading.dismiss(animation: true);
      notifyListeners();
    }
  }

  void loadOtherLineup(int userId) async {
    EasyLoading.show(status: 'Loading...');
    try {
      _lineup = await PlayersService.getLineupById(userId);
      resetAddedCards();
    } catch (e) {
      toastError(e.toString());
    } finally {
      EasyLoading.dismiss(animation: true);
      notifyListeners();
    }
  }

  void loadUserCard() async {
    EasyLoading.show(status: 'Loading...');
    try {
      _user = await UsersService.getUserIcon();
      resetAddedCards();
    } catch (e) {
      toastError(e.toString());
    } finally {
      EasyLoading.dismiss(animation: true);
      notifyListeners();
    }
  }

  void loadOtherUserCard(int userId) async {
    EasyLoading.show(status: 'Loading...');
    try {
      _user = await UsersService.getOtherUserIcon(userId);
      resetAddedCards();
    } catch (e) {
      toastError(e.toString());
    } finally {
      EasyLoading.dismiss(animation: true);
      notifyListeners();
    }
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