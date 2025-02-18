import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:piehme_cup_flutter/dialogs/toast_error.dart';
import 'package:piehme_cup_flutter/models/price.dart';
import 'package:piehme_cup_flutter/services/attendance_service.dart';

class AttendanceProvider with ChangeNotifier {

  List<String> _liturgyNames = <String>[];
  List<Price> _liturgies = <Price>[];

  List<Price>? get liturgies => _liturgies;
  List<String>? get liturgyNames => _liturgyNames;

  void loadLiturgies() async {
    EasyLoading.show(status: 'Loading...');
    try {
      _liturgies = await AttendanceService.getPrices();
      _liturgyNames = _liturgies.map((price) => price.name).toList();
    } catch (e) {
      toastError(e.toString());
    } finally {
      EasyLoading.dismiss(animation: true);
      notifyListeners();
    }
  }

}