import 'package:flutter/foundation.dart';
import 'package:piehme_cup_flutter/models/player.dart';
import 'package:piehme_cup_flutter/services/players_service.dart';

class PlayersStoreProvider with ChangeNotifier {

  List<Player> _items = <Player>[];
  bool _isLoaded = false;

  List<Player> get items => _items;
  bool get isLoaded => _isLoaded;

  Future<void> loadStore(String position) async {
    _isLoaded = false;
    _items = <Player>[];
    notifyListeners();
    _items = await PlayersService.getPlayersByPosition(position);
    _isLoaded = true;
    notifyListeners();
  }

}