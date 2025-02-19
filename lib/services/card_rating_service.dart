import 'dart:convert';

import 'package:piehme_cup_flutter/constants/api_constants.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import '../routes/app_routes.dart';

class CardRatingService {

  static Future<int> getCardRating() async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}/cardRating');
      final response = await http.get(
        url,
        headers: await ApiConstants.header(),
      );

      if (response.statusCode == 200) {
        return int.parse(response.body);
      } else {
        throw response.body;
      }
    } catch (e) {
      navigatorKey.currentState?.pushReplacementNamed(AppRoutes.splash);
      throw e.toString();
    }
  }

  static Future<void> upgradeRating(int delta) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/cardRating/$delta');

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

  static Future<int> getRatingPrice() async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}/prices/all');
      final response = await http.get(
        url,
        headers: await ApiConstants.header(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        var ratingPrice = jsonList.firstWhere((item) => item['name'] == 'Rating Price', orElse: () => null);
        if (ratingPrice != null) {
          return ratingPrice['coins'];
        } else {
          throw 'Rating Price not found';
        }
      } else {
        throw response.body;
      }
    } catch (e) {
      navigatorKey.currentState?.pushReplacementNamed(AppRoutes.splash);
      throw e.toString();
    }
  }

}