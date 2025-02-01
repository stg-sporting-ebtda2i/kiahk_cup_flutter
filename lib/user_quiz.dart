import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/header.dart';
import 'package:piehme_cup_flutter/styles.dart';

TextDirection getTextDirection(String text) {
  final rtlRegex = RegExp(r'[\u0600-\u06FF\u0590-\u05FF]');
  return rtlRegex.hasMatch(text) ? TextDirection.rtl : TextDirection.ltr;
}

class Question {
  final String question;
  final List<String> options;
  int selected;

  Question({
    required this.question,
    required this.options,
    this.selected = -1,
  });
}

class QuizPage extends StatefulWidget {
  QuizPage({super.key});

  List<Question> questions = <Question>[
    Question(question: "الاحد الاخير من كيهك بنقرأ جزء منين في الانجيل", options: <String>["لوقا 1", "يوحنا 1", "تكوين 5"]),
    Question(question: "3+3=", options: <String>["5", "6", "7", "8"]),
    Question(question: "4+4=", options: <String>["6", "7", "8", "9"]),
    Question(question: "5+5=", options: <String>["10", "11", "12", "13"]),
    Question(question: "6+6=", options: <String>["10", "12", "14", "16"]),
    Question(question: "7+7=", options: <String>["12", "14", "16", "18"]),
  ];

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
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
                  itemCount: widget.questions.length + 1,
                  itemBuilder: (context, index) {
                    if (index < widget.questions.length) {
                      return QuestionListItem(
                        question: widget.questions[index],
                        onOptionSelected: (selectedIndex) {
                          setState(() {
                            widget.questions[index].selected = selectedIndex;
                          });
                        },
                      );
                    } else {
                      return Container(
                        padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: btnStyle(),
                          child: Text(
                            'Submit',
                            style: btnTextStyle(),
                          ),
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

class QuestionListItem extends StatefulWidget {
  final Question question;
  final Function(int) onOptionSelected;

  const QuestionListItem({
    super.key,
    required this.question,
    required this.onOptionSelected,
  });

  @override
  State<QuestionListItem> createState() => _QuestionListItemState();
}

class _QuestionListItemState extends State<QuestionListItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white24,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.question.question,
              textDirection: getTextDirection(widget.question.question),
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            ...widget.question.options.asMap().entries.map((entry) {
              final optionIndex = entry.key;
              final optionText = entry.value;
              return Directionality(
                textDirection: getTextDirection(optionText),
                child: RadioListTile<int>(
                  title: Text(
                    optionText,
                    textDirection: getTextDirection(optionText),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  value: optionIndex,
                  groupValue: widget.question.selected,
                  onChanged: (value) {
                    setState(() {
                      widget.onOptionSelected(value!);
                    });
                  },
                  activeColor: Colors.greenAccent,
                  fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.selected)) {
                      return Colors.greenAccent; // Selected color
                    }
                    return Colors.white; // Unselected color
                  }),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}