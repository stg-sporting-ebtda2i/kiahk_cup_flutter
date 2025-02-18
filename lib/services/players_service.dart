import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:piehme_cup_flutter/constants/api_constants.dart';
import 'package:piehme_cup_flutter/main.dart';
import 'package:piehme_cup_flutter/models/player.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';
import 'package:piehme_cup_flutter/services/auth_service.dart';

class PlayersService {

  static Future<List<Player>> getPlayersByPosition(String position) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}/players/$position');

      final response = await http.get(
        url,
        headers: await ApiConstants.header(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Player.fromJson(json)).toList();
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

  static Future<List<Player>> getLineup() async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}/ownedPlayers/getLineup');

      final response = await http.get(
        url,
        headers: await ApiConstants.header(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Player.fromJson(json)).toList();
      } else if (response.statusCode == 403) {
        AuthService.logout();
        navigatorKey.currentState?.pushReplacementNamed(AppRoutes.login);
        throw 'User unauthorized';
      } else {
        throw 'Failed to load data: Error ${response.statusCode}';
      }
    } catch (e) {
      if (e.toString().contains('403')) {
        AuthService.logout();
        navigatorKey.currentState?.pushReplacementNamed(AppRoutes.login);
        throw 'User unauthorized';
      }else {
        throw 'Error: Connection failed';
      }
    }
  }

  static Future<List<Player>> getLineupById(int userId) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}/ownedPlayers/getLineup/$userId');

      final response = await http.get(
        url,
        headers: await ApiConstants.header(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Player.fromJson(json)).toList();
      } else if (response.statusCode == 403) {
        AuthService.logout();
        navigatorKey.currentState?.pushReplacementNamed(AppRoutes.login);
        throw 'User unauthorized';
      } else {
        throw 'Failed to load data: Error ${response.statusCode}';
      }
    } catch (e) {
      if (e.toString().contains('403')) {
        AuthService.logout();
        navigatorKey.currentState?.pushReplacementNamed(AppRoutes.login);
        throw 'User unauthorized';
      }else {
        throw 'Error: Connection failed';
      }
    }
  }

  static Future<void> buyPlayer(int playerId) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/ownedPlayers/buy/$playerId');

    try {
      final response = await http.patch(
        url,
        headers: await ApiConstants.header(),
      );
      if (response.statusCode == 200) {
        throw response.body;
      } else {
        throw response.body;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<void> sellPlayer(int playerId) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/ownedPlayers/sell/$playerId');

    try {
      final response = await http.patch(
        url,
        headers: await ApiConstants.header(),
      );
      if (response.statusCode == 200) {
        throw response.body;
      } else {
        throw response.body;
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
