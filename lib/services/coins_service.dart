import 'package:piehme_cup_flutter/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:piehme_cup_flutter/routes/app_routes.dart';
import 'package:piehme_cup_flutter/services/auth_service.dart';

import '../main.dart';

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
      } else if (response.statusCode == 403) {
        AuthService.logout();
        navigatorKey.currentState?.pushReplacementNamed(AppRoutes.login);
        throw ' ';
      } else {
        throw ' ';
      }
    } catch (e) {
      if (e.toString().contains('403')) {
        navigatorKey.currentState?.pushReplacementNamed(AppRoutes.login);
        throw ' ';
      } else {
      throw ' ';
      }
    }
  }

}