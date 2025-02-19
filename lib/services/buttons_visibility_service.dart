import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:piehme_cup_flutter/constants/api_constants.dart';

class ButtonsVisibilityService {

  static Future<List<String>> getVisibleBtnsNames() async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}/buttons-visibility');
      final response = await http.get(
        url,
        headers: await ApiConstants.header(),
      );

      if (response.statusCode == 200) {

        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((item) => item as String).toList();
      } else {
        throw 'Failed to load data: Error ${response.statusCode}';
      }
    } catch (e) {
      throw 'Error: Connection failed';
    }
  }

}