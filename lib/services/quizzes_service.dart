import 'dart:convert';
import 'package:piehme_cup_flutter/models/quiz.dart';
import 'package:piehme_cup_flutter/request.dart';

class QuizzesService {

  static Future<List<Quiz>> getQuizzes() async {
    final response = await Request.getFrom('/quizzes');

    final List<dynamic> jsonList = json.decode(response.body);
    List<Quiz> quizzes = jsonList.map((json) => Quiz.fromJson(json)).toList();

    return quizzes;
  }

  static Future<Quiz> getQuiz(String slug) async {
    final response = await Request.getFrom('/quizzes/$slug');

    final Map<String, dynamic> jsonQuiz = json.decode(response.body);
    Quiz quizz = Quiz.fromJson(jsonQuiz);

    return quizz;
  }

  static Future<bool> submitQuiz(String slug, Map<String, dynamic> answers) async {
    final response = await Request.postTo('/quizzes/$slug', {"questions": answers});

    return response.statusCode == 200;
  }
}
