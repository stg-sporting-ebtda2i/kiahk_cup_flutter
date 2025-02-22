import 'dart:convert';
import 'package:piehme_cup_flutter/models/card_icon.dart';
import 'package:piehme_cup_flutter/request.dart';

class IconsService {

  static Future<List<CardIcon>> getAllIcons() async {
    final response = await Request.getFrom('/icons');

    final List<dynamic> jsonList = json.decode(response.body);

    return jsonList.map((json) => CardIcon.fromJson(json)).toList();
  }

  static Future<List<CardIcon>> getOwnedIcons() async {
    final response = await Request.getFrom('/ownedIcons/getOwnedIcons');

    final List<dynamic> jsonList = json.decode(response.body);
    List<CardIcon> cardIcons = jsonList.map((json) => CardIcon.fromJson(json)).toList();
    for (CardIcon cardIcon in cardIcons) {
      cardIcon.owned = true;
    }

    return cardIcons;
  }

  static Future<CardIcon> getSelectedIcon() async {
    final response = await Request.getFrom('/selectIcon');

    final Map<String, dynamic> jsonMap = json.decode(response.body);
    return CardIcon.fromJson(jsonMap);
  }

  static Future<List<CardIcon>> getStoreIcons() async {
    final results = await Future.wait([getAllIcons(), getOwnedIcons(), getSelectedIcon()]);
    final List<CardIcon> allIcons = results[0] as List<CardIcon>;
    final List<CardIcon> ownedIcons = results[1] as List<CardIcon>;
    final CardIcon selectedIcon = results[2] as CardIcon;

    final Set<int> ownedIconIds = ownedIcons.map((icon) => icon.id).toSet();

    final filteredIcons = <CardIcon>[];
    for (var icon in allIcons) {
      if (icon.id == selectedIcon.id) {
        icon.selected = true;
      }
      if (ownedIconIds.contains(icon.id)) {
        icon.owned = true;
      }
      if (icon.available || icon.owned) {
        filteredIcons.add(icon);
      }
    }
    return filteredIcons;
  }

  static Future<void> buyIcon(int iconId) async {
    await (await Request("/ownedIcons/buy/$iconId").withToken()).patch();
  }

  static Future<void> sellIcon(int iconId) async {
    await (await Request("/ownedIcons/sell/$iconId").withToken()).patch();
  }

  static Future<void> selectIcon(int iconId) async {
    await (await Request("/selectIcon/$iconId").withToken()).patch();
  }

}
