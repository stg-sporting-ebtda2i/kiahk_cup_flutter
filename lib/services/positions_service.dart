import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:piehme_cup_flutter/constants/api_constants.dart';
import 'package:piehme_cup_flutter/models/Position.dart';

import '../main.dart';
import '../routes/app_routes.dart';

class PositionsService {

  static Future<List<Position>> getAllPositions() async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}/positions');

      final response = await http.get(
        url,
        headers: await ApiConstants.header(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Position.fromJson(json)).toList();
      } else {
        throw 'Failed to load data: Error ${response.statusCode}';
      }
    } catch (e) {
      navigatorKey.currentState?.pushReplacementNamed(AppRoutes.splash);
      throw e.toString();
    }
  }

  static Future<List<Position>> getOwnedPositions() async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}/ownedPositions/getOwnedPositions');
      final response = await http.get(
        url,
        headers: await ApiConstants.header(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        List<Position> positions = jsonList.map((json) => Position.fromJson(json)).toList();
        for (Position position in positions) {
          position.owned = true;
        }
        return positions;
      } else {
        throw 'Failed to load data: Error ${response.statusCode}';
      }
    } catch (e) {
      navigatorKey.currentState?.pushReplacementNamed(AppRoutes.splash);
      throw e.toString();
    }
  }

  static Future<Position> getSelectedPosition() async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}/selectPosition');
      final response = await http.get(
        url,
        headers: await ApiConstants.header(),
      );

      if (response.statusCode == 200) {

        final Map<String, dynamic> jsonMap = json.decode(response.body);
        return Position.fromJson(jsonMap);
      } else {
        return Position(id: 1, name: 'GK', price: '0');
      }
    } catch (e) {
        return Position(id: 1, name: 'GK', price: '0');
      }
    }

  static Future<List<Position>> getStorePositions() async {
    final results = await Future.wait([getAllPositions(), getOwnedPositions(), getSelectedPosition()]);
    final List<Position> allPositions = results[0] as List<Position>;
    final List<Position> ownedPositions = results[1] as List<Position>;
    final Position selectedPosition = results[2] as Position;

    final Set<int> ownedPositionsIds = ownedPositions.map((position) => position.id).toSet();

    for (var position in allPositions) {
      if (position.id == selectedPosition.id) {
        position.selected = true;
      }
          if (ownedPositionsIds.contains(position.id)) {
        position.owned = true;
      }
    }
    return allPositions;
  }

  static Future<void> buyPosition(int positionId) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/ownedPositions/buy/$positionId');

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

  static Future<void> sellPosition(int positionId) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/ownedPositions/sell/$positionId');

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

  static Future<void> selectPosition(int positionId) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/selectPosition/$positionId');
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