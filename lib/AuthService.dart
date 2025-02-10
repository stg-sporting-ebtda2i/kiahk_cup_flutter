import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Function to call the login API
  static Future<void> login(String username, String password) async {
    final url = Uri.parse('http://localhost:9000/login');

    try {
      // Send a POST request to the API
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // Extract the JWT token
        final String jwtToken = responseData['jwttoken'];
        final String role = responseData['role'];

        // Save the JWT token to shared preferences
        await _saveToken(jwtToken);
        await _saveRole(role);

        print('Login successful! Token: $jwtToken');
      } else {
        // Handle errors
        print('Login failed. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      // Handle exceptions
      print('Error during login: $e');
    }
  }

  // Function to save the JWT token to shared preferences
  static Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwttoken', token);
  }

  // Function to retrieve the JWT token from shared preferences
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwttoken');
  }

  // Function to save the JWT token to shared preferences
  static Future<void> _saveRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('role', role);
  }

  // Function to retrieve the JWT token from shared preferences
  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');
  }
}