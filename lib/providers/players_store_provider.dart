import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:piehme_cup_flutter/dialogs/loading.dart';
import 'package:piehme_cup_flutter/dialogs/toast_error.dart';
import 'package:piehme_cup_flutter/models/player.dart';
import 'package:piehme_cup_flutter/services/players_service.dart';

class PlayersStoreProvider with ChangeNotifier {

  List<Player> _items = <Player>[];

  List<Player> get items => _items;

  void loadStore(String position) async {
    await Loading.show(() async {
      _items = await PlayersService.getPlayersByPosition(position);
      notifyListeners();
    });
  }

}