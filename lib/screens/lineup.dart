import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/providers/base_lineup_provider.dart';
import 'package:piehme_cup_flutter/providers/lineup_provider.dart';
import 'package:piehme_cup_flutter/providers/other_lineup_provider.dart';
import 'package:piehme_cup_flutter/widgets/lineup_scores_panel.dart';
import 'package:provider/provider.dart';
import '../widgets/lineup_cards.dart';

class LineupPage extends StatelessWidget {
  final bool userLineup;

  const LineupPage({
    super.key,
    required this.userLineup,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userLineup
          ? Consumer<LineupProvider>(
              builder: (context, provider, child) {
                return _buildLineupWidget(provider);
              },
            )
          : Consumer<OtherLineupProvider>(
              builder: (context, provider, child) {
                return _buildLineupWidget(provider);
              },
            ),
    );
  }

  Widget _buildLineupWidget(BaseLineupProvider provider) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/backgrounds/lineup_background.jpg'),
          // Background image
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          if (!userLineup)
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  "${provider.user.name}'s Lineup",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          if (userLineup)
            SafeArea(child: ScoresPanel(provider: provider)),
          if (!userLineup)
            ScoresPanel(provider: provider),
          SizedBox(height: userLineup ? 40 : 20),
          Expanded(
            child: Center(
              child: Lineup(userLineup: userLineup),
            ),
          ),
        ],
      ),
    );
  }
}
