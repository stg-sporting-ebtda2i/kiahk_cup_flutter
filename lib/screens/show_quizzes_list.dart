import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/dialogs/loading.dart';
import 'package:piehme_cup_flutter/providers/quizzes_provider.dart';
import 'package:piehme_cup_flutter/widgets/quizzes_listitem.dart';
import 'package:provider/provider.dart';
import '../widgets/header.dart';

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
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await Loading.show(() async {
                        await context.read<QuizzesProvider>().loadQuizzes();
                      }, message: 'Loading Quizzes...', delay: Duration.zero);
                    },
                    color: Colors.black,
                    backgroundColor: Colors.greenAccent,
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