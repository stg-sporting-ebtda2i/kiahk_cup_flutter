import 'dart:collection';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:piehme_cup_flutter/dialogs/loading.dart';
import 'package:piehme_cup_flutter/dialogs/message.dart';
import 'package:piehme_cup_flutter/models/quiz.dart';
import 'package:piehme_cup_flutter/services/quizzes_service.dart';

class QuizzesProvider with ChangeNotifier {
  List<Quiz> _items = <Quiz>[];

  UnmodifiableListView<Quiz> get quizzes => UnmodifiableListView(_items);

  void loadQuizzes() async {
    await Loading.show(() async {
      _items = await QuizzesService.getQuizzes();
      notifyListeners();
    }, delay: Duration.zero);
  }

  Quiz _currentQuiz = Quiz.empty();

  Quiz get currentQuiz => _currentQuiz;

  void loadQuiz(String slug) async {
    _currentQuiz = Quiz.empty();

    await Loading.show(() async {
      _currentQuiz = await QuizzesService.getQuiz(slug);

      notifyListeners();
    }, delay: Duration.zero);
  }

  Future<void> submitQuiz(String slug, Map<String, dynamic> answers) async {
    await Loading.show(() async {
      bool result = await QuizzesService.submitQuiz(slug, answers);

      if (result) {
        loadQuizzes();

        toast('Quiz submitted successfully');
      }

      notifyListeners();
    }, message: 'Submitting...', delay: Duration(milliseconds: 0));
  }
}
