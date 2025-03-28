import 'package:flutter/cupertino.dart';
import 'package:piehme_cup_flutter/models/price.dart';
import 'package:piehme_cup_flutter/models/requested_attendance.dart';
import 'package:piehme_cup_flutter/services/attendance_service.dart';

class AttendanceProvider with ChangeNotifier {

  List<String> _liturgyNames = <String>[];
  List<Price> _liturgies = <Price>[];
  List<RequestedAttendance> _requestedList = <RequestedAttendance>[];

  List<Price>? get liturgies => _liturgies;
  List<String>? get liturgyNames => _liturgyNames;
  List<RequestedAttendance> get requestedList => _requestedList;

  Future<void> loadLiturgies() async {
    _liturgies = await AttendanceService.getPrices();
    _liturgyNames = _liturgies.map((price) => price.name).toList();
    notifyListeners();
  }

  Future<void> loadRequestedAttendances() async {
    _requestedList = await AttendanceService.getRequestedAttendances();
    notifyListeners();
  }

}