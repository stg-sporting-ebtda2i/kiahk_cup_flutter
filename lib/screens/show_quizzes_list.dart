import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/constants/app_colors.dart';
import 'package:piehme_cup_flutter/providers/quizzes_provider.dart';
import 'package:piehme_cup_flutter/widgets/header.dart';
import 'package:piehme_cup_flutter/widgets/quizzes_listitem.dart';
import 'package:provider/provider.dart';

class ShowQuizzesPage extends StatefulWidget {
  const ShowQuizzesPage({super.key});

  @override
  State<ShowQuizzesPage> createState() => _ShowQuizzesPageState();
}

class _ShowQuizzesPageState extends State<ShowQuizzesPage> {

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizzesProvider>(
      builder: (context, provider, child) {
        if (provider.isLoadingQuizzes && provider.quizzes.isEmpty) {
          return _buildLoadingState();
        }
        return _buildContentState(provider);
      },
    );
  }

  Widget _buildContentState(QuizzesProvider provider) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFF8A7C57),
            Color(0xFF16393F),
            Color(0xFF050514),
          ], begin: Alignment.topRight, end: Alignment.bottomLeft),
        ),
        child: Column(
          children: [
            SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 26),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black87,
                      Colors.black45,
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Mosab2at',
                        style: const TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Header(),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => provider.loadQuizzes(),
                color: Colors.black,
                backgroundColor: AppColors.brand,
                child: provider.quizzes.isEmpty
                    ? CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      child: _buildEmptyState(),
                    )
                  ],
                )
                    : ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: provider.quizzes.length,
                  itemBuilder: (context, index) {
                    final quiz = provider.quizzes[index];
                    return QuizListItem(quiz: quiz);
                  },
                ),
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFF8A7C57),
            Color(0xFF16393F),
            Color(0xFF050514),
          ], begin: Alignment.topRight, end: Alignment.bottomLeft),
        ),
        child: Column(
          children: [
            // Header
            SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 26),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black87,
                      Colors.black45,
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Mosab2at',
                        style: const TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Header(),
                    ],
                  ),
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
                      'Loading Quizzes...',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 12),

                    Text(
                      'Getting your quizzes ready',
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

  Widget _buildEmptyState() {
    return Expanded(
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
              'No Quizzes Available',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12),

            Text(
              'Check back later for new quizzes',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withAlpha(179),
              ),
            ),
          ],
        ),
      ),
    );
  }
}