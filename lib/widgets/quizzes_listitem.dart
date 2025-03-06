import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/dialogs/message.dart';
import 'package:piehme_cup_flutter/models/quiz.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';
import 'package:piehme_cup_flutter/widgets/quiz_question_listitem.dart';

class QuizListItem extends StatelessWidget {
  final Quiz quiz;

  const QuizListItem({
    super.key,
    required this.quiz,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(!quiz.isSolved) {
          Navigator.pushNamed(context, AppRoutes.quiz, arguments: {'quizSlug': quiz.slug});
        } else {
          toast("${quiz.name} already solved");
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: quiz.isSolved ? Color(0xD1FFFFFF) : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      quiz.name,
                      textDirection: getTextDirection(quiz.name),
                      softWrap: true,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                if (quiz.isSolved)
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "Solved",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                if(quiz.isSolved)
                Text(
                  "${quiz.coinsEarned}/",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),

                Text(
                  "${quiz.coins}€",
                  style: TextStyle(
                    fontSize: !quiz.isSolved ? 18 : 16,
                    fontWeight: !quiz.isSolved ? FontWeight.w600 : FontWeight.w400,
                    color: !quiz.isSolved ? Colors.black87 : Colors.black54,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            Text("${quiz.numberOfQuestions} ${quiz.numberOfQuestions == 1 ? "Question" : "Questions"}"),
          ],
        ),
      ),
    );
  }
}