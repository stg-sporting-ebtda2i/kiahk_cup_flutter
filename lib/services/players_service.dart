import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:piehme_cup_flutter/constants/api_constants.dart';
import 'package:piehme_cup_flutter/models/card_icon.dart';

class IconsService {

  static Future<List<CardIcon>> getAllIcons() async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}/icons');

      final response = await http.get(
        url,
        headers: await ApiConstants.header(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => CardIcon.fromJson(json)).toList();
      } else {
        throw 'Failed to load data: Error ${response.statusCode}';
      }
    } catch (e) {
      throw 'Error: Connection failed';
    }
  }

  static Future<List<CardIcon>> getOwnedIcons() async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}/ownedIcons/getOwnedIcons');
      final response = await http.get(
        url,
        headers: await ApiConstants.header(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        List<CardIcon> cardIcons = jsonList.map((json) => CardIcon.fromJson(json)).toList();
        for (CardIcon cardIcon in cardIcons) {
          cardIcon.owned = true;
        }
        return cardIcons;
      } else {
        throw 'Failed to load data: Error ${response.statusCode}';
      }
    } catch (e) {
      throw 'Error: Connection failed';
    }
  }

  static Future<List<CardIcon>> getStoreIcons() async {
    final results = await Future.wait([getAllIcons(), getOwnedIcons()]);
    final allIcons = results[0];
    final ownedIcons = results[1];

    final ownedIconIds = ownedIcons.map((icon) => icon.iconId).toSet();

    for (var icon in allIcons) {
      if (ownedIconIds.contains(icon.iconId)) {
        icon.owned = true;
      }
    }
    return allIcons;
  }

  static Future<void> buyIcon(int iconId) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/ownedIcons/buy/$iconId');

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

  static Future<void> sellIcon(int iconId) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/ownedIcons/sell/$iconId');

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
