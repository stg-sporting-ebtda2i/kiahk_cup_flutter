import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/models/quiz.dart';
import 'package:piehme_cup_flutter/providers/quizzes_provider.dart';
import 'package:piehme_cup_flutter/widgets/header.dart';
import 'package:piehme_cup_flutter/models/question.dart';
import 'package:piehme_cup_flutter/widgets/quiz_question_listitem.dart';
import 'package:piehme_cup_flutter/widgets/widgets_button.dart';
import 'package:provider/provider.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key, required this.quizSlug});

  final String quizSlug;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  @override
  void initState() {
    super.initState();
    _loadQuiz(widget.quizSlug);
  }

  void _loadQuiz(String quizSlug) {
    Provider.of<QuizzesProvider>(context, listen: false).loadQuiz(quizSlug);
  }

  void _submitQuiz() {

  }

  @override
  Widget build(BuildContext context) {
    QuizzesProvider provider = Provider.of<QuizzesProvider>(context);

    Quiz quiz = provider.currentQuiz;

    return Scaffold(
      body: Stack(
        children: [
          const Image(
            image: AssetImage('assets/other_background.png'),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Column(
            children: [
              const SafeArea(
                child: Header(),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: quiz.questions.length + 1,
                  itemBuilder: (context, index) {
                    if (index < quiz.questions.length) {
                      return QuestionListItem(
                        question: quiz.questions[index],
                        onOptionSelected: (selectedIndex) {
                          setState(() {

                          });
                        },
                      );
                    } else {
                      return Container(
                        padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
                        child: Button(
                          width: 100,
                          height: 50,
                          text: 'Submit',
                          fontSize: 18,
                          onClick: _submitQuiz,
                          isLoading: false,
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}