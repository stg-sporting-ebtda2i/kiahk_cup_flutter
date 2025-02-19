import 'package:flutter/cupertino.dart';
import 'package:piehme_cup_flutter/services/buttons_visibility_service.dart';

class ButtonsVisibilityProvider with ChangeNotifier {

  List<String> _visibleBtn = <String> [];

  ButtonsVisibilityProvider() {
    refreshData();
  }

  Future<void> refreshData() async {
    _visibleBtn = await ButtonsVisibilityService.getVisibleBtnsNames();
    notifyListeners();
  }

  bool isVisible(String btn) {
    return _visibleBtn.contains(btn);
  }

}