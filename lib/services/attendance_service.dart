import 'dart:convert';
import 'package:piehme_cup_flutter/models/price.dart';
import 'package:piehme_cup_flutter/models/requested_attendance.dart';
import 'package:piehme_cup_flutter/request.dart';

class AttendanceService {

  static Future<List<Price>> getPrices() async {
    final response = await Request.getFrom('/prices');

    final List<dynamic> jsonList = json.decode(response.body);

    return jsonList.map((json) => Price.fromJson(json)).toList();
  }

  static Future<void> requestAttendance(String liturgyName, String date) async {
    await Request.patchTo("/attendance/$liturgyName", {'date': date});
  }

  static Future<List<RequestedAttendance>> getRequestedAttendances() async {
    final response = await Request.getFrom('/attendances');
    final Map<String, dynamic> responseBody = json.decode(response.body);
    final List<dynamic> jsonList = responseBody['data'];
    return jsonList.map((json) => RequestedAttendance.fromJson(json)).toList();
  }

}