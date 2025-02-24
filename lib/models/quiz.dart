import 'dart:convert';

import 'package:piehme_cup_flutter/models/question.dart';

class Quiz {
  final int id;
  final String name;
  final String slug;
  final int coins;
  bool isSolved;
  int coinsEarned;
  final List<Question> questions;

  Quiz({
    required this.id,
    required this.name,
    required this.slug,
    required this.coins,
    required this.isSolved,
    required this.coinsEarned,
    this.questions = const <Question>[],
  });

  factory Quiz.empty() {
    return Quiz(id: 0, name: '', slug: '', coins: 0, questions: [], isSolved: false, coinsEarned: 0);
  }

  factory Quiz.fromJson(Map<String, dynamic> json) {
    List<Question> questions = [];

    if (json['questions'] != null) {
      questions = json['questions'].map<Question>((question) => Question.fromJson(question)).toList();
    }

    return Quiz(
      id: json['id'],
      name: utf8.decode(json['name'].codeUnits),
      slug: json['slug'],
      coins: json['coins'],
      isSolved: json['isSolved'],
      coinsEarned: json['coinsEarned'],
      questions: questions,
    );
  }
}