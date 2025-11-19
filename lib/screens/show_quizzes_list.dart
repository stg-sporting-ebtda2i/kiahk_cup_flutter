import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/constants/app_colors.dart';
import 'package:piehme_cup_flutter/providers/quizzes_provider.dart';
import 'package:piehme_cup_flutter/states/empty_state.dart';
import 'package:piehme_cup_flutter/states/loading_state.dart';
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
                  child: Builder(
                    builder: (context) {
                      if (provider.isLoadingQuizzes &&
                          provider.quizzes.isEmpty) {
                        return _buildLoadingState();
                      }
                      return RefreshIndicator(
                        onRefresh: () => provider.loadQuizzes(),
                        color: Colors.black,
                        backgroundColor: AppColors.brand,
                        child: provider.quizzes.isEmpty
                            ? CustomScrollView(
                                slivers: [
                                  SliverToBoxAdapter(
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
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingState() {
    return LoadingState(
        iconData: Icons.quiz_rounded,
        title: 'Loading Quizzes...',
        subtitle: 'Getting your quizzes ready');
  }

  Widget _buildEmptyState() {
    return EmptyState(
        iconData: Icons.quiz_rounded,
        title: 'No Quizzes Available',
        subtitle: 'Check back later for new quizzes');
  }
}
