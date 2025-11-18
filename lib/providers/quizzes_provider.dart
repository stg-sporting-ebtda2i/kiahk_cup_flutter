import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:piehme_cup_flutter/dialogs/message.dart';
import 'package:piehme_cup_flutter/models/quiz.dart';
import 'package:piehme_cup_flutter/services/quizzes_service.dart';

class QuizzesProvider with ChangeNotifier {
  List<Quiz> _items = <Quiz>[];
  bool _isLoadingQuiz = true;
  bool _isLoadingQuizzes = true;
  bool _isSubmitting = false;

  bool get isLoadingQuiz => _isLoadingQuiz;
  bool get isLoadingQuizzes => _isLoadingQuizzes;
  bool get isSubmitting => _isSubmitting;

  UnmodifiableListView<Quiz> get quizzes => UnmodifiableListView(_items);

  Future<void> loadQuizzes() async {
    _isLoadingQuizzes = true;
    notifyListeners();
    _items = await QuizzesService.getQuizzes();
    notifyListeners();
  }

  Quiz _currentQuiz = Quiz.empty();

  Quiz get currentQuiz => _currentQuiz;

  void loadQuiz(String slug) async {
    _isLoadingQuiz = true;
    notifyListeners();
    _currentQuiz = Quiz.empty();
    _currentQuiz = await QuizzesService.getQuiz(slug);
    _isLoadingQuiz = false;
    notifyListeners();
  }

  Future<void> submitQuiz(String slug, Map<String, dynamic> answers) async {
    _isSubmitting = true;
    notifyListeners();
    bool result = await QuizzesService.submitQuiz(slug, answers);
    _isSubmitting = false;
    notifyListeners();
    if (result) {
      toast("Submitted successfully");
    } else {
      toast("Something went wrong");
    }
  }
}
