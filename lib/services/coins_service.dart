import 'dart:convert';

import 'package:piehme_cup_flutter/request.dart';

class CoinsService {

  static Future<int> getCoins() async {
    final response = await Request.getFrom('/coins');

    return jsonDecode(response.body)["coins"] ?? 0;
  }

}