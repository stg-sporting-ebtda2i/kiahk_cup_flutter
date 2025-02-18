import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:piehme_cup_flutter/dialogs/toast_error.dart';
import 'package:piehme_cup_flutter/models/Position.dart';
import 'package:piehme_cup_flutter/models/player.dart';
import 'package:piehme_cup_flutter/models/user.dart';
import 'package:piehme_cup_flutter/services/leaderboard_service.dart';
import 'package:piehme_cup_flutter/services/players_service.dart';
import 'package:piehme_cup_flutter/services/positions_service.dart';

class LineupProvider with ChangeNotifier {

  late List<Player> _lineup = <Player>[];
  late Position _userPosition = Position(id: -1, name: 'GK', price: '0');
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
  Position get userPosition => _userPosition;
  User get user => _user;

  void loadLineup() async {
    EasyLoading.show(status: 'Loading...');
    try {
      _lineup = await PlayersService.getLineup();
      _userPosition = await PositionsService.getSelectedPosition();
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
      _user = User(
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
      List<User> leaderboard = await LeaderboardService.getLeaderboard();
      _user = leaderboard.firstWhere((user) => user.id == userId);
    } catch (e) {
      toastError(e.toString());
    } finally {
      EasyLoading.dismiss(animation: true);
      notifyListeners();
    }
  }

}