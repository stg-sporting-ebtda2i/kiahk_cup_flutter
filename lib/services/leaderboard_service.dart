import 'dart:convert';

import 'package:piehme_cup_flutter/constants/api_constants.dart';
import 'package:piehme_cup_flutter/models/user.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import '../routes/app_routes.dart';

class LeaderboardService {

  static Future<List<User>> getLeaderboard() async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}/leaderboard');

      final response = await http.get(
        url,
        headers: await ApiConstants.header(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body)['users'];
        return jsonList.map((json) => User.fromJson(json)).toList();
      } else {
        throw 'Failed to load data: Error ${response.statusCode}';
      }
    } catch (e) {
      if (e.toString().toLowerCase().contains('error 400')) {
        throw 'No players found in this position';
      } else {
        navigatorKey.currentState?.pushReplacementNamed(AppRoutes.splash);
        throw 'Error: Connection failed';
      }
    }
  }

  static Future<List<int>> getStats() async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}/leaderboard');

      final response = await http.get(
        url,
        headers: await ApiConstants.header(),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonList = json.decode(response.body);
        List<int> stats = <int>[
          jsonList['avgRating']?.round() ?? 0,
          jsonList['maxRating']?.round() ?? 0,
        ];
        return stats;
      } else {
        throw 'Failed to load data: Error ${response.statusCode}';
      }
    } catch (e) {
      if (e.toString().toLowerCase().contains('error 400')) {
        throw 'No players found in this position';
      } else {
        navigatorKey.currentState?.pushReplacementNamed(AppRoutes.splash);
        throw 'Error: Connection failed';
      }
    }
  }

}