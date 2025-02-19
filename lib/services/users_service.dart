import 'dart:convert';
import 'package:piehme_cup_flutter/constants/api_constants.dart';
import 'package:piehme_cup_flutter/models/user.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import '../routes/app_routes.dart';

class UsersService {

  static Future<User> getUserIcon() async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}/userCard');
      final response = await http.get(
        url,
        headers: await ApiConstants.header(),
      );

      if (response.statusCode == 200) {

        final Map<String, dynamic> jsonMap = json.decode(response.body);
        return User.fromJson(jsonMap);
      } else {
        throw 'Failed to load data: Error ${response.statusCode}';
      }
    } catch (e) {
      navigatorKey.currentState?.pushReplacementNamed(AppRoutes.splash);
      throw 'Error: Connection failed';
    }
  }

  static Future<User> getOtherUserIcon(int userId) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}/userCard/$userId');
      final response = await http.get(
        url,
        headers: await ApiConstants.header(),
      );

      if (response.statusCode == 200) {

        final Map<String, dynamic> jsonMap = json.decode(response.body);
        return User.fromJson(jsonMap);
      } else {
        throw 'Failed to load data: Error ${response.statusCode}';
      }
    } catch (e) {
      navigatorKey.currentState?.pushReplacementNamed(AppRoutes.splash);
      throw 'Error: Connection failed';
    }
  }

}