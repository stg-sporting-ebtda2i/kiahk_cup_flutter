import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/dialogs/message.dart';
import 'package:piehme_cup_flutter/models/quiz.dart';
import 'package:piehme_cup_flutter/providers/header_provider.dart';
import 'package:piehme_cup_flutter/providers/quizzes_provider.dart';
import 'package:piehme_cup_flutter/widgets/header.dart';
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

  void _loadQuiz(String quizSlug) async {
    try {
      Provider.of<QuizzesProvider>(context, listen: false).loadQuiz(quizSlug);
    } catch (error) {
      // Handle error if needed
      print('Error loading quiz: $error');
      toast('Error loading quiz');
    }
  }

  void _submitQuiz(QuizzesProvider provider, HeaderProvider header) async {
    try {
      await provider.submitQuiz(widget.quizSlug, answers);
      if (mounted) {
        header.refreshCoins();
        Navigator.of(context).pop();
      }
    } catch (error) {
      // Handle submission error
      print('Error submitting quiz: $error');
      toast('Failed to submit quiz. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<QuizzesProvider, HeaderProvider>(
      builder: (context, provider, header, child) {
        Quiz quiz = provider.currentQuiz;

        if (provider.isLoadingQuiz) {
          return _buildLoadingState();
        }

        if (!provider.isLoadingQuiz && quiz.questions.isEmpty) {
          return _buildErrorState();
        }
        return _buildQuestionsState(provider, header);
      },
    );
  }

  Widget _buildQuestionsState(QuizzesProvider provider, HeaderProvider header) {
    Quiz quiz = provider.currentQuiz;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1a2a3a),
              Color(0xFF0d1b2a),
              Color(0xFF050a14),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          children: [
            // Header
            SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withAlpha(204),
                      Colors.black.withAlpha(102),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    // Back Button
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(26),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),

                    // Quiz Title
                    Expanded(
                      child: Text(
                        quiz.name,
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 4,
                              color: Colors.black.withAlpha(128),
                            ),
                          ],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    SizedBox(width: 16),
                    Header(),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Column(
                children: [
                  // Enhanced Progress Indicator
                  _buildEnhancedProgressIndicator(quiz),

                  // Questions Area
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        _scrollToIndex(index);
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

                  // Submit Button
                  Visibility(
                    visible: _currentPageIndex == quiz.questions.length - 1,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withAlpha(204),
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomButton(
                            text: provider.isSubmitting
                                ? 'Submitting...'
                                : 'Submit Quiz',
                            onPressed: provider.isSubmitting
                                ? () {}
                                : () => _submitQuiz(provider, header),
                            isLoading: provider.isSubmitting,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1a2a3a),
              Color(0xFF0d1b2a),
              Color(0xFF050a14),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          children: [
            // Header with loading state
            SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withAlpha(204),
                      Colors.black.withAlpha(102),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(26),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        height: 24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white.withAlpha(26),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Header(),
                  ],
                ),
              ),
            ),

            // Loading content
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Loading animation
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(26),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.quiz_rounded,
                        color: Colors.white.withAlpha(179),
                        size: 30,
                      ),
                    ),
                    SizedBox(height: 24),

                    // Loading text
                    Text(
                      'Loading Quiz...',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 12),

                    Text(
                      'Getting your questions ready',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(179),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1a2a3a),
              Color(0xFF0d1b2a),
              Color(0xFF050a14),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          children: [
            // Header
            SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withAlpha(204),
                      Colors.black.withAlpha(102),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(26),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Quiz',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Header(),
                  ],
                ),
              ),
            ),

            // Error content
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Error icon
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.red.withAlpha(26),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.error_outline_rounded,
                          color: Colors.red.shade300,
                          size: 50,
                        ),
                      ),
                      SizedBox(height: 24),

                      // Error title
                      Text(
                        'Quiz Not Available',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12),

                      // Error message
                      Text(
                        'We couldn\'t load the quiz. Please check your connection and try again.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withAlpha(179),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 32),

                      // Retry button
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () => _loadQuiz(widget.quizSlug),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade600,
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.refresh_rounded,
                                size: 20,
                                color: Colors.white,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Try Again',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnhancedProgressIndicator(Quiz quiz) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        children: [
          // Progress Text
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question ${_currentPageIndex + 1} of ${quiz.questions.length}',
                style: TextStyle(
                  color: Colors.white.withAlpha(204),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${((_currentPageIndex + 1) / quiz.questions.length * 100).toInt()}%',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),

          // Progress Dots
          SizedBox(
            height: 32,
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
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: isCurrent ? 36 : 32,
                    height: isCurrent ? 36 : 32,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: isAnswered ? Colors.green : Colors.grey.shade700,
                      shape: BoxShape.circle,
                      border: isCurrent
                          ? Border.all(color: Colors.blue.shade300, width: 3)
                          : Border.all(
                              color: Colors.white.withAlpha(77), width: 1),
                      boxShadow: isCurrent
                          ? [
                              BoxShadow(
                                color: Colors.blue.withAlpha(128),
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                            ]
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        (index + 1).toString(),
                        style: TextStyle(
                          color: isAnswered
                              ? Colors.white
                              : Colors.white.withAlpha(204),
                          fontWeight: FontWeight.bold,
                          fontSize: isCurrent ? 14 : 12,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
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
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _scrollController.animateTo(
        0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}
