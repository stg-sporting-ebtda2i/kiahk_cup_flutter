import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:piehme_cup_flutter/constants/api_constants.dart';
import 'package:piehme_cup_flutter/main.dart';
import 'package:piehme_cup_flutter/models/price.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';

class AttendanceService {

  static Future<List<Price>> getPrices() async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}/prices');
      final response = await http.get(
        url,
        headers: await ApiConstants.header(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Price.fromJson(json)).toList();
      } else {
        throw 'Error: ${response.statusCode}';
      }
    } catch (e) {
      navigatorKey.currentState?.pushReplacementNamed(AppRoutes.splash);
      throw 'Connection Failed';
    }
  }

  static Future<void> requestAttendance(String liturgyName, String date) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/attendance/$liturgyName');

    try {
      final response = await http.patch(
        url,
        headers: await ApiConstants.header(),
        body: jsonEncode({
          'date': date,
        }),
      );
      if (response.statusCode == 200) {
        throw 'Attendance requested successfully';
      } else {
        throw response.body;
      }
    } catch (e) {
      navigatorKey.currentState?.pushReplacementNamed(AppRoutes.splash);
      throw 'Connection Failed';
    }
  }

}