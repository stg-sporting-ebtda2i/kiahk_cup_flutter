import 'dart:convert';
import 'package:piehme_cup_flutter/request.dart';

class ButtonsVisibilityService {

  static Future<List<String>> getVisibleBtnsNames() async {
    final response = await Request.getFrom('/buttons-visibility');

    final List<dynamic> jsonList = json.decode(response.body);
    return jsonList.map((item) => item as String).toList();
  }
}