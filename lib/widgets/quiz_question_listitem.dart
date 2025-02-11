import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/models/question.dart';

TextDirection getTextDirection(String text) {
  final rtlRegex = RegExp(r'[\u0600-\u06FF\u0590-\u05FF]');
  return rtlRegex.hasMatch(text) ? TextDirection.rtl : TextDirection.ltr;
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
        ),
      ),
    );
  }
}