import 'dart:convert';
import 'package:piehme_cup_flutter/models/position.dart';
import 'package:piehme_cup_flutter/request.dart';

class PositionsService {

  static Future<List<Position>> getAllPositions() async {
    final response = await Request.getFrom("/positions");

    final List<dynamic> jsonList = json.decode(response.body);
    return jsonList.map((json) => Position.fromJson(json)).toList();
  }

  static Future<List<Position>> getOwnedPositions() async {
    final response = await Request.getFrom("/ownedPositions/getOwnedPositions");

    final List<dynamic> jsonList = json.decode(response.body);
    List<Position> positions = jsonList.map((json) => Position.fromJson(json)).toList();
    for (Position position in positions) {
      position.owned = true;
    }
    return positions;
  }

  static Future<Position> getSelectedPosition() async {
    final response = await Request.getFrom("/selectPosition");

    final Map<String, dynamic> jsonMap = json.decode(response.body);
    return Position.fromJson(jsonMap);
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
    await Request.patchTo("/ownedPositions/buy/$positionId");
  }

  static Future<void> sellPosition(int positionId) async {
    await Request.patchTo("/ownedPositions/sell/$positionId");
  }

  static Future<void> selectPosition(int positionId) async {
    await Request.patchTo("/selectPosition/$positionId");
  }
}