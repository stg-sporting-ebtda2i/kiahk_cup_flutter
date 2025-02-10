import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _loginUrl = 'http://localhost:9000/login';
  static const String _tokenKey = 'jwttoken';
  static const String _roleKey = 'role';

  static Future<bool> login(String username, String password) async {
    final url = Uri.parse(_loginUrl);

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
        if (responseData.containsKey('jwttoken') && responseData.containsKey('role')) {
          final String jwtToken = responseData['jwttoken'];
          final String role = responseData['role'];

          await _saveToken(jwtToken);
          await _saveRole(role);
          return true; // Login successful
        } else {
          throw Exception('Invalid response: Missing token or role');
        }
      } else {
        throw Exception('Login failed: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Error during login: $e');
    }
  }

  static Future<void> _saveToken(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_tokenKey, token);
    } catch (e) {
      throw Exception('Failed to save token: $e');
    }
  }

  static Future<String?> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_tokenKey);
    } catch (e) {
      throw Exception('Failed to retrieve token: $e');
    }
  }

  static Future<void> _saveRole(String role) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_roleKey, role);
    } catch (e) {
      throw Exception('Failed to save role: $e');
    }
  }

  static Future<String?> getRole() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_roleKey);
    } catch (e) {
      throw Exception('Failed to retrieve role: $e');
    }
  }

  static Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_tokenKey);
      await prefs.remove(_roleKey);
    } catch (e) {
      throw Exception('Failed to logout: $e');
    }
  }
}