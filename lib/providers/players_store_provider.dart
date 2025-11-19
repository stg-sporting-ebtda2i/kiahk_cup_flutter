import 'package:flutter/foundation.dart';
import 'package:piehme_cup_flutter/models/player.dart';
import 'package:piehme_cup_flutter/services/players_service.dart';

class PlayersStoreProvider with ChangeNotifier {

  List<Player> _items = <Player>[];
  bool _isLoading = false;
  String _currentPosition = '';

  List<Player> get items => _items;
  bool get isLoading => _isLoading;

  Future<void> loadStore(String position) async {
    if (position == _currentPosition) return;
    _currentPosition = position;
    _isLoading = true;
    _items = <Player>[];
    notifyListeners();
    _items = await PlayersService.getPlayersByPosition(position);
    _isLoading = false;
    notifyListeners();
  }

}