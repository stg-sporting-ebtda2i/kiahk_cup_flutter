import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:piehme_cup_flutter/dialogs/loading.dart';
import 'package:piehme_cup_flutter/dialogs/toast_error.dart';
import 'package:piehme_cup_flutter/models/Position.dart';
import 'package:piehme_cup_flutter/services/positions_service.dart';

class PositionsStoreProvider with ChangeNotifier {

  List<Position> _items = <Position>[];

  List<Position> get items => _items;

  void loadStore() async {
    await Loading.show(() async {
      _items = await PositionsService.getStorePositions();
      notifyListeners();
    });
  }

}