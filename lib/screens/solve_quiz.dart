import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:piehme_cup_flutter/models/quiz.dart';
import 'package:piehme_cup_flutter/providers/quizzes_provider.dart';
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

  Map<String, dynamic> answers = {};

  @override
  void initState() {
    super.initState();
    _loadQuiz(widget.quizSlug);
  }

  void _loadQuiz(String quizSlug) {
    Provider.of<QuizzesProvider>(context, listen: false).loadQuiz(quizSlug);
  }

  void _submitQuiz() async {
    await Provider.of<QuizzesProvider>(context, listen: false).submitQuiz(widget.quizSlug, answers);

    if(mounted) Navigator.of(context).pop();
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
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 3),
                child: Text(
                  quiz.name,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Visibility(
                visible: quiz.name.isNotEmpty,
                child: Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: quiz.questions.length + 1,
                    itemBuilder: (context, index) {
                      if (index < quiz.questions.length) {
                        return QuestionListItem(
                          question: quiz.questions[index],
                          answer: answers[quiz.questions[index].id.toString()],
                          setAnswer: (answer) {
                            setState(() {
                              answers[quiz.questions[index].id.toString()] = answer;
                            });
                          },
                        );
                      } else {
                        return Container(
                          padding: const EdgeInsets.fromLTRB(10, 35, 10, 15),
                          child: Button(
                            width: 150,
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}