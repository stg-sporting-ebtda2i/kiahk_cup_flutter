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
    final bool isRTL = _isRTL(quiz.name);

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: quiz.isSolved ? _getSolvedDarkColor() : _getAvailableDarkColor(),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(102),
            blurRadius: 12,
            offset: Offset(0, 4),
            spreadRadius: 1,
          ),
          if (!quiz.isSolved)
            BoxShadow(
              color: Colors.blue.withAlpha(51),
              blurRadius: 8,
              spreadRadius: 1,
            ),
        ],
        border: Border.all(
          color: quiz.isSolved ? Colors.green.withAlpha(102) : Colors.blue.withAlpha(77),
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (!quiz.isSolved) {
              Navigator.pushNamed(context, AppRoutes.quiz, arguments: {'quizSlug': quiz.slug});
            } else {
              toast("${quiz.name} already solved");
            }
          },
          borderRadius: BorderRadius.circular(16),
          splashColor: quiz.isSolved ? Colors.green.withAlpha(51) : Colors.blue.withAlpha(77),
          highlightColor: quiz.isSolved ? Colors.green.withAlpha(26) : Colors.blue.withAlpha(38),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row with RTL support
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: isRTL
                      ? _buildRTLHeader()
                      : _buildLTRHeader(),
                ),

                SizedBox(height: 16),

                // Stats Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Coins Section
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: quiz.isSolved ? Colors.green.withAlpha(38) : Colors.blue.withAlpha(38),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: quiz.isSolved ? Colors.green.withAlpha(77) : Colors.blue.withAlpha(77),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.monetization_on_rounded,
                            color: quiz.isSolved ? Colors.green.shade300 : Colors.blue.shade300,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (quiz.isSolved)
                                Text(
                                  "Earned",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: quiz.isSolved ? Colors.green.shade300 : Colors.blue.shade300,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  if (quiz.isSolved)
                                    Text(
                                      "${quiz.coinsEarned}/",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: quiz.isSolved ? Colors.green.shade300 : Colors.blue.shade300,
                                      ),
                                    ),
                                  Row(
                                    children: [
                                      Text(
                                        "${quiz.coins}",
                                        style: TextStyle(
                                          fontSize: quiz.isSolved ? 14 : 16,
                                          fontWeight: quiz.isSolved ? FontWeight.w600 : FontWeight.bold,
                                          color: quiz.isSolved ? Colors.green.shade300 : Colors.blue.shade300,
                                        ),
                                      ),
                                      SizedBox(width: 8,),
                                      Image.asset(
                                        'assets/icons/coin.png',
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Questions Count
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(51),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.withAlpha(77),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.quiz_rounded,
                            color: Colors.grey.shade400,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Questions",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade400,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "${quiz.numberOfQuestions}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                if (quiz.isSolved)
                  SizedBox(height: 12),

                // Progress Indicator for solved quizzes
                if (quiz.isSolved)
                  Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.green.withAlpha(77),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: 1.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.green.shade500, Colors.green.shade400],
                          ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildLTRHeader() {
    return [
      // Quiz Name (LTR)
      Expanded(
        child: Container(
          padding: EdgeInsets.only(right: 12),
          child: Text(
            quiz.name,
            textDirection: TextDirection.ltr,
            softWrap: true,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: quiz.isSolved ? Colors.grey.shade400 : Colors.white,
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),

      // Solved Badge (LTR - right side)
      if (quiz.isSolved)
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade600, Colors.green.shade700],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withAlpha(102),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle_rounded,
                color: Colors.white,
                size: 16,
              ),
              SizedBox(width: 6),
              Text(
                "Solved",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
    ];
  }

  List<Widget> _buildRTLHeader() {
    return [
      // Solved Badge (RTL - left side)
      if (quiz.isSolved)
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade600, Colors.green.shade700],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withAlpha(102),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle_rounded,
                color: Colors.white,
                size: 16,
              ),
              SizedBox(width: 6),
              Text(
                "Solved",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),

      // Quiz Name (RTL)
      Expanded(
        child: Container(
          padding: EdgeInsets.only(left: 12),
          child: Text(
            quiz.name,
            textDirection: TextDirection.rtl,
            softWrap: true,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: quiz.isSolved ? Colors.grey.shade400 : Colors.white,
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    ];
  }

  bool _isRTL(String text) {
    final rtlRegex = RegExp(
      r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]',
    );
    return rtlRegex.hasMatch(text);
  }

  Color _getSolvedDarkColor() {
    return Colors.grey.shade900.withAlpha(204);
  }

  Color _getAvailableDarkColor() {
    return Colors.grey.shade900.withAlpha(125);
  }
}