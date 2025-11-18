import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/dialogs/loading.dart';
import 'package:piehme_cup_flutter/providers/quizzes_provider.dart';
import 'package:piehme_cup_flutter/widgets/header.dart';
import 'package:piehme_cup_flutter/widgets/quizzes_listitem.dart';
import 'package:provider/provider.dart';

class ShowQuizzesPage extends StatefulWidget {
  const ShowQuizzesPage({super.key});

  @override
  State<ShowQuizzesPage> createState() => _ShowQuizzesPageState();
}

class _ShowQuizzesPageState extends State<ShowQuizzesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFF8A7C57),
            Color(0xFF16393F),
            Color(0xFF050514),
          ], begin: Alignment.topRight, end: Alignment.bottomLeft),
          // image: DecorationImage(
          //   image: AssetImage('assets/other_background.png'),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: Column(
          children: [
            SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 26),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black87,
                      Colors.black45,
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Mosab2at',
                        style: const TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Header(),
                    ],
                  ),
                ),
              ),
            ),
            Consumer<QuizzesProvider>(
                builder: (context, provider, child) {
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await Loading.show(() async {
                          await context.read<QuizzesProvider>().loadQuizzes();
                        }, message: 'Loading Quizzes...', delay: Duration.zero);
                      },
                      color: Colors.black,
                      backgroundColor: Colors.greenAccent,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: provider.quizzes.length,
                        itemBuilder: (context, index) {
                          final quiz = provider.quizzes[index];
                          return QuizListItem(quiz: quiz);
                        },
                      ),
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
