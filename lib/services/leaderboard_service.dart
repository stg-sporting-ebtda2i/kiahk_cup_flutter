import 'dart:convert';

import 'package:piehme_cup_flutter/models/user.dart';
import 'package:piehme_cup_flutter/request.dart';

class LeaderboardService {

  static Future<List<User>> getLeaderboard() async {
    final response = await Request.getFrom('/leaderboard');

    final List<dynamic> jsonList = json.decode(response.body)['users'];
    return jsonList.map((json) => User.fromJson(json)).toList();
  }

  static Future<List<int>> getStats() async {
    final response = await Request.getFrom('/leaderboard');

    final Map<String, dynamic> jsonList = json.decode(response.body);
    List<int> stats = <int>[
      jsonList['avgRating']?.round() ?? 0,
      jsonList['maxRating']?.round() ?? 0,
    ];
    return stats;
  }

}