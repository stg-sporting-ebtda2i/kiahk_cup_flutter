import 'dart:convert';

import 'package:piehme_cup_flutter/constants/api_constants.dart';
import 'package:piehme_cup_flutter/models/user.dart';
import 'package:http/http.dart' as http;

class LeaderboardService {

  static Future<List<User>> getLeaderboard() async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}/leaderboard');

      final response = await http.get(
        url,
        headers: await ApiConstants.header(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => User.fromJson(json)).toList();
      } else {
        throw 'Failed to load data: Error ${response.statusCode}';
      }
    } catch (e) {
      if (e.toString().toLowerCase().contains('error 400')) {
        throw 'No players found in this position';
      } else {
        throw e.toString();
        throw 'Error: Connection failed';
      }
    }
  }

}