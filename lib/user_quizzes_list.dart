import 'package:flutter/material.dart';
import 'header.dart';
import 'quiz.dart';

class ShowQuizzesScreen extends StatefulWidget {
  // late final List<Quiz> quizzes;

final List<Quiz> quizzes = <Quiz>[
  Quiz(name: 'Quiz 1', coins: 100, isSolved: false),
  Quiz(name: 'Quiz 2', coins: 200, isSolved: true),
  Quiz(name: 'Quiz 3', coins: 150, isSolved: false),
  Quiz(name: 'Quiz 4', coins: 100, isSolved: false),
  Quiz(name: 'Quiz 5', coins: 200, isSolved: true),
  Quiz(name: 'Quiz 6', coins: 150, isSolved: false),
  Quiz(name: 'Quiz 7', coins: 100, isSolved: false)
];

  @override
  State<ShowQuizzesScreen> createState() => _ShowQuizzesScreenState();
}

class _ShowQuizzesScreenState extends State<ShowQuizzesScreen> {
  late List<Quiz> _quizzes;

  @override
  void initState() {
    super.initState();
    _quizzes = widget.quizzes; // Initialize state from props
  }

  void _toggleSolved(int index) {
    setState(() {
      _quizzes[index].isSolved = !_quizzes[index].isSolved;
    });
  }

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
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                padding: const EdgeInsets.all(15),
                itemCount: _quizzes.length,
                itemBuilder: (context, index) {
                  final quiz = _quizzes[index];
                  return QuizListItem(
                    title: quiz.name,
                    coins: quiz.coins.toString(),
                    isSolved: quiz.isSolved,
                    onTap: () => _toggleSolved(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// for admin
class QuizListItem extends StatelessWidget {
  final String title;
  final String coins;
  final bool isSolved;
  final VoidCallback onTap;

  const QuizListItem({
    super.key,
    required this.title,
    required this.coins,
    required this.isSolved,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: 0.75,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(42),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/quiz.png',
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 30),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      '$coins Coins',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              if (isSolved)
                Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}