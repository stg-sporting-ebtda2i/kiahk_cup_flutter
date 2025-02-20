import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:piehme_cup_flutter/constants/api_constants.dart';
import 'package:piehme_cup_flutter/main.dart';
import 'package:piehme_cup_flutter/models/quiz.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';

class QuizzesService {

  static Future<List<Quiz>> getQuizzes() async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}/quizzes');

      final response = await http.get(
        url,
        headers: await ApiConstants.header(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        List<Quiz> quizzes = jsonList.map((json) => Quiz.fromJson(json)).toList();

        return quizzes;
      } else {
        throw 'Failed to load data: Error ${response.statusCode}';
      }
    } catch (e) {
      if (e.toString().toLowerCase().contains('error 400')) {
      throw 'No quizzes found';
      } else {
        navigatorKey.currentState?.pushReplacementNamed(AppRoutes.splash);
        throw e.toString();
      }
    }
  }

  static Future<Quiz> getQuiz(String slug) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}/quizzes/$slug');

      final response = await http.get(
        url,
        headers: await ApiConstants.header(),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonQuiz = json.decode(response.body);
        Quiz quizz = Quiz.fromJson(jsonQuiz);

        return quizz;
      } else {
        throw 'Failed to load data: Error ${response.statusCode}';
      }
    } catch (e) {
      if (e.toString().toLowerCase().contains('error 400')) {
        throw 'Quiz not found';
      } else {
        navigatorKey.currentState?.pushReplacementNamed(AppRoutes.splash);
        throw e.toString();
      }
    }
  }
}
