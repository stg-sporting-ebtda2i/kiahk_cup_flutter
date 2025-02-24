import 'dart:developer';

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
    Provider.of<QuizzesProvider>(context, listen: false).loadQuizzes();
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
            Consumer<QuizzesProvider>(
              builder: (context, provider, child) {
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(15),
                    itemCount: provider.quizzes.length,
                    itemBuilder: (context, index) {
                      final quiz = provider.quizzes[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: QuizListItem(quiz: quiz),
                      );
                    },
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}