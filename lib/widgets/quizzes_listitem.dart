import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/dialogs/message.dart';
import 'package:piehme_cup_flutter/models/quiz.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';

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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    quiz.name,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                if(quiz.isSolved)
                Text(
                  "${quiz.coinsEarned}/",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
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
          ],
        ),
      ),
    );
  }
}