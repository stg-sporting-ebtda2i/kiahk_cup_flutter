
import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/models/option.dart';
import 'package:piehme_cup_flutter/models/question.dart';


TextDirection getTextDirection(String text) {
  final rtlRegex = RegExp(r'[\u0600-\u06FF\u0590-\u05FF]');
  return rtlRegex.hasMatch(text) ? TextDirection.rtl : TextDirection.ltr;
}

class QuestionListItem extends StatelessWidget {
  final Question question;
  final Function(Object) setAnswer;
  final Object? answer;

  const QuestionListItem({
    super.key,
    required this.question,
    required this.setAnswer,
    required this.answer,
  });

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
              question.title,
              textDirection: getTextDirection(question.title),
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),

            QuestionInputMethod(
              questionType: question.type,
              options: question.options,
              setAnswer: setAnswer,
              answer: answer,
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionInputMethod extends StatelessWidget {
  final QuestionType questionType;
  final List<Option> options;
  final Function(Object) setAnswer;
  final Object? answer;

  const QuestionInputMethod({
    super.key,
    required this.questionType,
    required this.options,
    required this.setAnswer,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {

    if (questionType == QuestionType.choice) {
      return ChoiceInputMethod(
        options: options,
        setAnswer: setAnswer,
        answer: answer,
      );
    }

    if (questionType == QuestionType.reorder) {
      return ReorderInputMethod(
        options: options,
        setAnswer: setAnswer,
        answer: answer as List<int>?,
      );
    }

    return Container();
  }
}

class ChoiceInputMethod extends StatelessWidget {
  final List<Option> options;
  final Function(Object) setAnswer;
  final Object? answer;

  const ChoiceInputMethod({
    super.key,
    required this.options,
    required this.setAnswer,
    required this.answer,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...options.map((option) {
          return Directionality(
            textDirection: getTextDirection(option.name),
            child: RadioListTile<int>(
              title: Text(
                option.name,
                textDirection: getTextDirection(option.name),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              value: option.order,
              groupValue: answer as int?,
              onChanged: (value) {

                setAnswer(value!);

              },
              activeColor: Colors.greenAccent,
              fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.selected)) {
                  return Colors.greenAccent; // Selected color
                }
                return Colors.white; // Unselected color
              }),
            ),
          );
        }),
      ],
    );
  }
}

class ReorderInputMethod extends StatefulWidget {
  final List<Option> options;
  final Function(Object) setAnswer;
  final List<int>? answer;

  const ReorderInputMethod({
    super.key,
    required this.options,
    required this.setAnswer,
    required this.answer,
  });

  @override
  State<ReorderInputMethod> createState() => _ReorderInputMethodState();
}

class _ReorderInputMethodState extends State<ReorderInputMethod> {
  late List<Option> options;

  @override
  void initState() {
    options = List.from(widget.options); // Create a copy of the options list
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      proxyDecorator: (child, index, animation) {
        return Material(
          elevation: 8,
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: child,
          ),
        );
      },
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = options.removeAt(oldIndex);
          options.insert(newIndex, item);
          widget.setAnswer(options.map((option) => option.order).toList());
        });
      },
      children: [
        ...options.map((option) {
          return Container(
            key: Key("options-${option.id}"),
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white),
            ),
            child: Directionality(
              textDirection: getTextDirection(option.name),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    option.name,
                    textDirection: getTextDirection(option.name),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),

                  const Icon(
                    Icons.drag_handle,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}