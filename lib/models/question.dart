import 'dart:convert';

import 'package:piehme_cup_flutter/models/option.dart';

enum QuestionType {
  choice,
  multipleCorrectChoices,
  written,
  reorder;

  static QuestionType fromString(String type) {
    type = type.toLowerCase();
    switch (type) {
      case 'choice':
        return QuestionType.choice;
      case 'written':
        return QuestionType.written;
      case 'reorder':
        return QuestionType.reorder;
      case 'multipleCorrectChoices':
        return QuestionType.multipleCorrectChoices;
      default:
        return QuestionType.choice;
    }
  }
}

class Question {
  final int id;
  final String title;
  final String? picture;
  final List<Option> options;
  final QuestionType type;
  final int coins;

  Question({
    required this.id,
    required this.title,
    required this.picture,
    required this.options,
    required this.type,
    required this.coins,
  });

  static Question fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      title: utf8.decode(json['title'].codeUnits),
      picture: json['picture'],
      coins: json['coins'],
      type: QuestionType.fromString(json['type']),
      options: json['options'].map<Option>((option) => Option.fromJson(option)).toList(),
    );
  }
}