import 'dart:convert';

import 'package:piehme_cup_flutter/request.dart';

class CardRatingService {

  static Future<int> getCardRating() async {
    final response = await Request.getFrom('/cardRating');

    return int.parse(response.body);
  }

  static Future<void> upgradeRating(int delta) async {
    await Request.patchTo("/cardRating/$delta");
  }

  static Future<int> getRatingPrice() async {
    final response = await Request.getFrom('/prices/Rating Price');

    final Map<String, dynamic> rating = json.decode(response.body);

    return rating['coins'];
  }

}