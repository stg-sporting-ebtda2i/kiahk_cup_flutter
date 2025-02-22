import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:piehme_cup_flutter/dialogs/loading.dart';
import 'package:piehme_cup_flutter/dialogs/toast_error.dart';
import 'package:piehme_cup_flutter/models/player.dart';
import 'package:piehme_cup_flutter/models/quiz.dart';
import 'package:piehme_cup_flutter/models/quiz.dart';
import 'package:piehme_cup_flutter/models/quiz.dart';
import 'package:piehme_cup_flutter/services/players_service.dart';
import 'package:piehme_cup_flutter/services/quizzes_service.dart';

class QuizzesProvider with ChangeNotifier {
  List<Quiz> _items = <Quiz>[];

  List<Quiz> get quizzes => _items;

  void loadQuizzes() async {
    await Loading.show(() async {
      _items = await QuizzesService.getQuizzes();
      notifyListeners();
    });
  }

  Quiz _currentQuiz =
      Quiz(id: 0, name: '', slug: '', coins: 0, questions: [], isSolved: false);

  Quiz get currentQuiz => _currentQuiz;

  void loadQuiz(String slug) async {
    _currentQuiz = Quiz(id: 0, name: '', slug: '', coins: 0, questions: [], isSolved: false);

    await Loading.show(() async {
      _currentQuiz = await QuizzesService.getQuiz(slug);

      notifyListeners();
    });
  }

  Future<void> submitQuiz(String slug, Map<String, dynamic> answers) async {
    await Loading.show(() async {
      bool result = await QuizzesService.submitQuiz(slug, answers);

      if (result) {
        loadQuizzes();

        toast('Quiz submitted successfully');
      }

      notifyListeners();
    }, message: 'Submitting...', delay: Duration(milliseconds: 1));
  }
}
