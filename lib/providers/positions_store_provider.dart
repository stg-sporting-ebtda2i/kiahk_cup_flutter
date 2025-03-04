import 'package:flutter/cupertino.dart';
import 'package:piehme_cup_flutter/models/position.dart';
import 'package:piehme_cup_flutter/services/positions_service.dart';

class PositionsStoreProvider with ChangeNotifier {

  List<Position> _items = <Position>[];

  List<Position> get items => _items;

  Future<void> loadStore() async {
    _items = await PositionsService.getStorePositions();
    notifyListeners();
  }

}