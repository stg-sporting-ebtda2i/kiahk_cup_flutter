import 'dart:convert';
import 'package:piehme_cup_flutter/models/price.dart';
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

}