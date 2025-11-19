import 'package:flutter/cupertino.dart';
import 'package:piehme_cup_flutter/dialogs/message.dart';
import 'package:piehme_cup_flutter/models/price.dart';
import 'package:piehme_cup_flutter/models/requested_attendance.dart';
import 'package:piehme_cup_flutter/services/attendance_service.dart';

class AttendanceProvider with ChangeNotifier {
  bool _isLoadingRequests = true;
  bool _isLoadingLiturgies = true;
  bool _isSubmittingRequest = false;
  bool get isLoadingRequests => _isLoadingRequests;
  bool get isLoadingLiturgies => _isLoadingLiturgies;
  bool get isSubmittingRequest => _isSubmittingRequest;

  List<String> _liturgyNames = <String>[];
  List<Price> _liturgies = <Price>[];
  List<RequestedAttendance> _requestedList = <RequestedAttendance>[];

  List<Price>? get liturgies => _liturgies;
  List<String>? get liturgyNames => _liturgyNames;
  List<RequestedAttendance> get requestedList => _requestedList;

  Future<void> loadLiturgies() async {
    _isLoadingLiturgies = true;
    notifyListeners();
    _liturgies = await AttendanceService.getPrices();
    _liturgyNames = _liturgies.map((price) => price.name).toList();
    _isLoadingLiturgies = false;
    notifyListeners();
  }

  Future<void> loadRequestedAttendances() async {
    _isLoadingRequests = true;
    notifyListeners();
    _requestedList = await AttendanceService.getRequestedAttendances();
    _isLoadingRequests = false;
    notifyListeners();
  }

  Future<void> submitAttendance({
    required String selectedEvent,
    required String apiDate,
  }) async {
    _isSubmittingRequest = true;
    notifyListeners();
    try {
      await AttendanceService.requestAttendance(selectedEvent, apiDate);
      await loadRequestedAttendances();
      toast('Attendance requested successfully!');
    } catch (e) {
      toast(e.toString());
    } finally {
      _isSubmittingRequest = false;
      notifyListeners();
    }
  }
}
