import 'package:flutter/cupertino.dart';
import 'package:piehme_cup_flutter/dialogs/loading.dart';
import 'package:piehme_cup_flutter/models/price.dart';
import 'package:piehme_cup_flutter/services/attendance_service.dart';

class AttendanceProvider with ChangeNotifier {

  List<String> _liturgyNames = <String>[];
  List<Price> _liturgies = <Price>[];

  List<Price>? get liturgies => _liturgies;
  List<String>? get liturgyNames => _liturgyNames;

  void loadLiturgies() async {
    await Loading.show(() async {
      _liturgies = await AttendanceService.getPrices();
      _liturgyNames = _liturgies.map((price) => price.name).toList();
      notifyListeners();
    });
  }

}