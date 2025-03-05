import 'package:flutter/material.dart';
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/lineup_background.png'),
            // Background image
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SafeArea(
              child: Column(
                children: [
                  if(!userLineup)
                  Consumer<OtherLineupProvider>(
                    builder: (context, provider, child) {
                      return Container(
                        height: 40,
                        color: Colors.white30,
                        child: Center(
                          child: Visibility(
                            visible: provider.user.name.isNotEmpty,
                            child: Text(
                              "${provider.user.name}'s Lineup",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  ),

                  const ScoresPanel(),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Lineup(
                    userLineup: userLineup),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
