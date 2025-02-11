import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/widgets/header.dart';
import 'package:piehme_cup_flutter/models/question.dart';
import 'package:piehme_cup_flutter/widgets/quiz_question_listitem.dart';
import 'package:piehme_cup_flutter/widgets/widgets_button.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key, required this.quizID});

  final int quizID;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  late List<Question> _questions;

  @override
  void initState() {
    super.initState();
    _loadQuiz(widget.quizID);
  }

  void _loadQuiz(int quizID) {
    _questions = <Question>[
      Question(question: "الاحد الاخير من كيهك بنقرأ جزء منين في الانجيل", options: <String>["لوقا 1", "يوحنا 1", "تكوين 5"]),
      Question(question: "3+3=", options: <String>["5", "6", "7", "8"]),
      Question(question: "4+4=", options: <String>["6", "7", "8", "9"]),
      Question(question: "5+5=", options: <String>["10", "11", "12", "13"]),
      Question(question: "6+6=", options: <String>["10", "12", "14", "16"]),
      Question(question: "7+7=", options: <String>["12", "14", "16", "18"]),
    ];
  }

  void _submitQuiz() {

  }

  @override
  Widget build(BuildContext context) {
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
                  itemCount: _questions.length + 1,
                  itemBuilder: (context, index) {
                    if (index < _questions.length) {
                      return QuestionListItem(
                        question: _questions[index],
                        onOptionSelected: (selectedIndex) {
                          setState(() {
                            _questions[index].selected = selectedIndex;
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