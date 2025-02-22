import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:piehme_cup_flutter/constants/api_constants.dart';
import 'package:piehme_cup_flutter/utils/string_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  static Future<bool> login(String username, String password) async {
    final url = Uri.parse(ApiConstants.authEndpoint);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username.trim(),
          'password': password.trim(),
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // Check if the response contains a token and role
        if (responseData.containsKey('jwttoken')) {
          final String jwtToken = responseData['jwttoken'];
          await _saveToken(jwtToken);
          await _saveName(StringUtils.capitalizeWords(username.trim()));
          return true; // Login successful
        } else {
          throw Exception('Login failed: Missing token');
        }
      } else if (response.statusCode==400) {
        throw Exception('Login failed: Incorrect username or password');
      } else if (response.statusCode==404) {
        throw Exception('Login failed: User not found');
      } else {
        throw Exception('Login failed: Error');
      }
    } catch (e) {
      if (e.toString().toLowerCase().contains('incorrect username or password')) {
        throw Exception('Login failed: Incorrect username or password');
      } else {
        throw Exception('Error during login: Connection failed');
      }
    }
  }

  static Future<void> _saveToken(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(ApiConstants.tokenKey, token);
    } catch (e) {
      throw Exception('Failed to save token: $e');
    }
  }

  static Future<void> _saveName(String name) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(ApiConstants.nameKey, name);
    } catch (e) {
      throw Exception('Failed to save name: $e');
    }
  }

  static Future<bool> checkValidToken(String token) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/userCard');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token",
      },
    );

    return response.statusCode == 200;
  }

  static Future<String?> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(ApiConstants.tokenKey);
      if (token == null) {
        return null;
      }

      if(! await checkValidToken(token)) {
        return null;
      }

      return token;
    } catch (e) {
      throw Exception('Failed to retrieve token: $e');
    }
  }

  static Future<String?> getName() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(ApiConstants.nameKey);
    } catch (e) {
      throw Exception('Failed to retrieve name: $e');
    }
  }

  static Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(ApiConstants.tokenKey);
      await prefs.remove(ApiConstants.nameKey);
    } catch (e) {
      throw Exception('Failed to logout: $e');
    }
  }

  static Future<bool> hasToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(ApiConstants.tokenKey);
  }
}