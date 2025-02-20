import 'dart:convert';
import 'dart:developer';

import 'package:piehme_cup_flutter/models/option.dart';

enum QuestionType {
  choice,
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
      default:
        return QuestionType.choice;
    }
  }
}

class Question {
  final String title;
  final String? picture;
  final List<Option> options;
  final QuestionType type;
  int selected;

  Question({
    required this.title,
    required this.picture,
    required this.options,
    required this.type,
    this.selected = -1,
  });

  static Question fromJson(Map<String, dynamic> json) {
    return Question(
      title: utf8.decode(json['title'].codeUnits),
      picture: json['picture'],
      type: QuestionType.fromString(json['type']),
      options: json['options'].map<Option>((option) => Option.fromJson(option)).toList(),
      selected: -1,
    );
  }
}