import 'dart:convert';
import 'package:piehme_cup_flutter/models/player.dart';
import 'package:piehme_cup_flutter/request.dart';

class PlayersService {

  static Future<List<Player>> getPlayersByPosition(String position) async {
    final response = await Request.getFrom('/players/$position');

    final List<dynamic> jsonList = json.decode(response.body);
    List<Player> players = jsonList.map((json) => Player.fromJson(json)).toList();
    List<Player> ownedPlayers = await getLineup();
    Set<int> ownedPlayerIds = ownedPlayers.map((player) => player.id).toSet();
    for (Player p in players) {
      if (ownedPlayerIds.contains(p.id)) {
        p.owned = true;
      }
    }
    return players;
  }

  static Future<List<Player>> getLineup() async {
    final response = await Request.getFrom('/ownedPlayers/getLineup');

    final List<dynamic> jsonList = json.decode(response.body);

    return jsonList.map((json) => Player.fromJson(json)).toList();
  }

  static Future<List<Player>> getLineupById(int userId) async {
    final response = await Request.getFrom('/ownedPlayers/getLineup/$userId');

    final List<dynamic> jsonList = json.decode(response.body);

    return jsonList.map((json) => Player.fromJson(json)).toList();
  }

  static Future<void> buyPlayer(int playerId) async {
    await Request.patchTo('/ownedPlayers/buy/$playerId');
  }

  static Future<void> sellPlayer(int playerId) async {
    await Request.patchTo('/ownedPlayers/sell/$playerId');
  }
}
