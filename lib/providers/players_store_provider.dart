import 'package:flutter/foundation.dart';
import 'package:piehme_cup_flutter/dialogs/loading.dart';
import 'package:piehme_cup_flutter/models/player.dart';
import 'package:piehme_cup_flutter/services/players_service.dart';

class PlayersStoreProvider with ChangeNotifier {

  List<Player> _items = <Player>[];
  bool _isLoaded = false;

  List<Player> get items => _items;
  bool get isLoaded => _isLoaded;

  void loadStore(String position) async {
    _items = [];
    _isLoaded = false;

    await Loading.show(() async {
      _items = await PlayersService.getPlayersByPosition(position);
      _isLoaded = true;
      notifyListeners();
    }, delay: Duration(milliseconds: 0));
  }

}