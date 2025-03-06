import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/models/quiz.dart';
import 'package:piehme_cup_flutter/providers/header_provider.dart';
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
  final Map<String, dynamic> answers = {};
  late PageController _pageController;
  late ScrollController _scrollController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _scrollController = ScrollController();
    _loadQuiz(widget.quizSlug);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _loadQuiz(String quizSlug) {
    Provider.of<QuizzesProvider>(context, listen: false).loadQuiz(quizSlug);
  }

  void _submitQuiz() async {
    await Provider.of<QuizzesProvider>(context, listen: false)
        .submitQuiz(widget.quizSlug, answers);

    if (mounted) {
      context.read<HeaderProvider>().refreshCoins();
      Navigator.of(context).pop();
    }
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
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
                child: Text(
                  quiz.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              _buildProgressIndicator(quiz),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    _scrollToIndex(index+3);
                    setState(() => _currentPageIndex = index);
                  },
                  children: quiz.questions.map((question) {
                    return QuestionListItem(
                      question: question,
                      answer: answers[question.id.toString()],
                      setAnswer: (answer) {
                        setState(() {
                          answers[question.id.toString()] = answer;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              Visibility(
                visible: _currentPageIndex == quiz.questions.length - 1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Button(
                    width: double.infinity,
                    height: 50,
                    text: 'Submit',
                    fontSize: 18,
                    onClick: _submitQuiz,
                    isLoading: false,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(Quiz quiz) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: quiz.questions.length,
        itemBuilder: (context, index) {
          final question = quiz.questions[index];
          final isAnswered = answers.containsKey(question.id.toString());
          final isCurrent = index == _currentPageIndex;

          return GestureDetector(
            onTap: () {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeInOut,
                );
              _scrollToIndex(index);
            },
            child: Container(
              width: 24,
              height: 24,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: isAnswered ? Colors.green : Colors.grey[300],
                shape: BoxShape.circle,
                border: isCurrent
                    ? Border.all(color: Colors.blue, width: 2)
                    : null,
              ),
              child: Center(
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(
                    color: isAnswered ? Colors.black : (isCurrent ? Colors.blue : Colors.black),
                    fontWeight: isAnswered ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _scrollToIndex(int index) {
    final double itemWidth = 40;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double visibleItems = screenWidth / itemWidth;

    if (index > visibleItems - 2) {
      final double offset = (index - visibleItems + 2) * itemWidth;

      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
      );
    } else {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
      );
    }
  }
}