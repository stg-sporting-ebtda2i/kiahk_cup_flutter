import 'dart:convert';
import 'package:piehme_cup_flutter/request.dart';
import 'package:piehme_cup_flutter/utils/string_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  static const String tokenKey = 'jwttoken';
  static const String nameKey = 'name';
  static const String confirmedKey = 'confirmed';

  static Future<bool> login(String username, String password) async {
    final response = await Request("/login").contentJson().post({'username': username.trim(), 'password': password.trim()});

    final Map<String, dynamic> responseData = jsonDecode(response.body);
    await _saveResponse(responseData);
    return true;
  }

  static Future<void> delete() async {
    await (await Request("/users/delete").contentJson().withToken()).delete();

    await logout();
  }

  static Future<bool> register(String username, String password, String schoolYear) async {
    final response = await Request("/register").contentJson()
        .post({
        'username': username, 'password': password, 'schoolYear': schoolYear
        });

    final Map<String, dynamic> responseData = jsonDecode(response.body);

    await _saveResponse(responseData);
    return true;
  }

  static Future<List<String>> getSchoolYears() async {
    final response = await Request("/schoolYears").contentJson().get();

    final List<dynamic> responseData = jsonDecode(response.body);

    List<String> schoolYears = [];
    for (Map<String, dynamic> schoolYear in responseData) {
      schoolYears.add(schoolYear['name']);
    }

    return schoolYears;
  }

  static Future<void> _saveResponse(Map<String, dynamic> response) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(AuthService.confirmedKey, response["confirmed"]);
    await prefs.setString(AuthService.tokenKey, response["jwttoken"]);
    await prefs.setString(
        AuthService.nameKey,
        StringUtils.capitalizeWords(response["username"])
    );
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

  static Future<bool> getConfirmed() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AuthService.confirmedKey) ?? false;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AuthService.tokenKey);
    await prefs.remove(AuthService.nameKey);
    await prefs.remove(AuthService.confirmedKey);
  }

  static Future<bool> hasToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(AuthService.tokenKey);
  }
}
