import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/providers/quizzes_provider.dart';
import 'package:piehme_cup_flutter/widgets/quizzes_listitem.dart';
import 'package:provider/provider.dart';
import '../widgets/header.dart';
import '../models/quiz.dart';

class ShowQuizzesPage extends StatefulWidget {
  const ShowQuizzesPage({super.key});

  @override
  State<ShowQuizzesPage> createState() => _ShowQuizzesPageState();
}

class _ShowQuizzesPageState extends State<ShowQuizzesPage> {
  @override
  void initState() {
    super.initState();
    context.read<QuizzesProvider>().loadQuizzes();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuizzesProvider>(context);

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
                itemCount: provider.quizzes.length,
                itemBuilder: (context, index) {
                  final quiz = provider.quizzes[index];
                  return QuizListItem(quiz: quiz);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}