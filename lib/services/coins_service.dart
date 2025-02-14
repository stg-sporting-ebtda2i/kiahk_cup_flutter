import 'package:piehme_cup_flutter/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class CoinsService {

  static Future<String> getCoins() async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}/coins');
      final response = await http.get(
        url,
        headers: await ApiConstants.header(),
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw ' ';
      }
    } catch (e) {
      throw ' ';
    }
  }

}