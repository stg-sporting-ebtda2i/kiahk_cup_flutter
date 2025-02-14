import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:piehme_cup_flutter/dialogs/toast_error.dart';
import 'package:piehme_cup_flutter/models/Position.dart';
import 'package:piehme_cup_flutter/services/positions_service.dart';

class PositionsStoreProvider with ChangeNotifier {

  List<Position> _items = <Position>[];

  List<Position> get items => _items;

  void loadStore() async {
    EasyLoading.show(status: 'Loading...');
    try {
      _items = await PositionsService.getStorePositions();
    } catch (e) {
      toastError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      EasyLoading.dismiss(animation: true);
      notifyListeners();
    }
  }

}