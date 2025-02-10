import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/widgets/lineup_scores_panel.dart';
import 'lineup.dart';

class LineupPage extends StatefulWidget {
  final bool userLineup;
  const LineupPage({
    super.key,
    required this.userLineup,
  });

  @override
  State<LineupPage> createState() => _LineupPageState();
}

class _LineupPageState extends State<LineupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/lineup_background.png'), // Background image
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const ScoresPanel(),
            Expanded(
              child: Center(
                child: Lineup(userLineup: widget.userLineup),
              ),
            ),
          ],
        ),
      ),
    );
  }
}