import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
    EasyLoading.show(status: 'Loading...');
    _items = <Quiz>[];
    try {
      _items = await QuizzesService.getQuizzes();
    } catch (e) {
      toastError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      EasyLoading.dismiss(animation: true);
      notifyListeners();
    }
  }

  Quiz _currentQuiz = Quiz(id: 0, name: '', slug: '', coins: 0, questions: [], isSolved: false);
  Quiz get currentQuiz => _currentQuiz;

  void loadQuiz(String slug) async {
    _currentQuiz = Quiz(id: 0, name: '', slug: '', coins: 0, questions: [], isSolved: false);
    EasyLoading.show(status: 'Loading...');
    try {
      _currentQuiz = await QuizzesService.getQuiz(slug);
    } catch (e) {
      toastError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      EasyLoading.dismiss(animation: true);
      notifyListeners();
    }
  }

  Future<bool> submitQuiz(String slug, Map<String, dynamic> answers) async {
    EasyLoading.show(status: 'Submitting...');
    try {
      bool result = await QuizzesService.submitQuiz(slug, answers);

      if(result) loadQuizzes();

      return result;
    } catch (e) {
      toastError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      EasyLoading.dismiss(animation: true);
      notifyListeners();
    }

    return false;
  }

}