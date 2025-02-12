import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/widgets/quizzes_listitem.dart';
import '../widgets/header.dart';
import '../models/quiz.dart';

class ShowQuizzesPage extends StatefulWidget {
  const ShowQuizzesPage({super.key});

  @override
  State<ShowQuizzesPage> createState() => _ShowQuizzesPageState();
}

class _ShowQuizzesPageState extends State<ShowQuizzesPage> {
  late List<Quiz> _quizzes;

  @override
  void initState() {
    super.initState();
    _refreshQuizzes();
  }

  void _refreshQuizzes() {
    _quizzes = <Quiz>[
      Quiz(name: 'Quiz 1', coins: 100, isSolved: false),
      Quiz(name: 'Quiz 2', coins: 200, isSolved: true),
      Quiz(name: 'Quiz 3', coins: 150, isSolved: false),
      Quiz(name: 'Quiz 4', coins: 100, isSolved: false),
      Quiz(name: 'Quiz 5', coins: 200, isSolved: true),
      Quiz(name: 'Quiz 6', coins: 150, isSolved: false),
      Quiz(name: 'Quiz 7', coins: 100, isSolved: false)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/other_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SafeArea(child: Header()),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                padding: const EdgeInsets.all(15),
                itemCount: _quizzes.length,
                itemBuilder: (context, index) {
                  final quiz = _quizzes[index];
                  return QuizListItem(
                    title: quiz.name,
                    coins: quiz.coins.toString(),
                    isSolved: quiz.isSolved,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}