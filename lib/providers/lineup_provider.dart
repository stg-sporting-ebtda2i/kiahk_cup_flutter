import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:piehme_cup_flutter/dialogs/toast_error.dart';
import 'package:piehme_cup_flutter/models/Position.dart';
import 'package:piehme_cup_flutter/models/player.dart';
import 'package:piehme_cup_flutter/services/players_service.dart';
import 'package:piehme_cup_flutter/services/positions_service.dart';

class LineupProvider with ChangeNotifier {

  late List<Player> _lineup = <Player>[];
  late Position _userPosition = Position(id: -1, name: 'GK', price: '0');

  List<Player> get lineup => _lineup;
  Position get userPosition => _userPosition;

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

}