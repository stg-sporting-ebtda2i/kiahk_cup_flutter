import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:piehme_cup_flutter/dialogs/toast_error.dart';
import 'package:piehme_cup_flutter/models/player.dart';
import 'package:piehme_cup_flutter/services/players_service.dart';

class PlayersStoreProvider with ChangeNotifier {

  List<Player> _items = <Player>[];

  List<Player> get items => _items;

  void loadStore(String position) async {
    EasyLoading.show(status: 'Loading...');
    _items = <Player>[];
    try {
      _items = await PlayersService.getPlayersByPosition(position);
    } catch (e) {
      toastError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      EasyLoading.dismiss(animation: true);
      notifyListeners();
    }
  }

}