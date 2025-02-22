import 'dart:convert';
import 'package:piehme_cup_flutter/request.dart';
import 'package:piehme_cup_flutter/utils/string_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  static const String tokenKey = 'jwttoken';
  static const String nameKey = 'name';
  
  static Future<bool> login(String username, String password) async {
    final response = await Request("/login").contentJson().post({'username': username.trim(), 'password': password.trim()});

    final Map<String, dynamic> responseData = jsonDecode(response.body);

    final String jwtToken = responseData['jwttoken'];
    await _saveToken(jwtToken);
    await _saveName(StringUtils.capitalizeWords(username.trim()));
    return true;
  }

  static Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(AuthService.tokenKey, token);
  }

  static Future<void> _saveName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AuthService.nameKey, name);
  }

  static Future<bool> checkValidToken(String token) async {
    final response = await (await Request("/userCard").contentJson().withToken()).get();

    return response.statusCode == 200;
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(AuthService.tokenKey);
    if (token == null) {
      return null;
    }

    if (!await checkValidToken(token)) {
      return null;
    }

    return token;
  }

  static Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AuthService.nameKey);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AuthService.tokenKey);
    await prefs.remove(AuthService.nameKey);
  }

  static Future<bool> hasToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(AuthService.tokenKey);
  }
}
