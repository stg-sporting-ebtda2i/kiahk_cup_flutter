import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:piehme_cup_flutter/dialogs/toast_error.dart';
import 'package:piehme_cup_flutter/models/card_icon.dart';
import 'package:piehme_cup_flutter/services/icons_service.dart';

class IconsStoreProvider with ChangeNotifier {

  List<CardIcon> _items = <CardIcon>[];

  List<CardIcon> get items => _items;

  void loadStore() async {
    EasyLoading.show(status: 'Loading...');
    try {
      _items = await IconsService.getStoreIcons();
    } catch (e) {
      toastError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      notifyListeners();
      EasyLoading.dismiss(animation: true);
    }
  }

}