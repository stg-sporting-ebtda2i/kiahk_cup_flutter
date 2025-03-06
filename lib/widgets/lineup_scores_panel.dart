import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/providers/base_lineup_provider.dart';
import 'package:piehme_cup_flutter/providers/lineup_provider.dart';
import 'package:piehme_cup_flutter/providers/other_lineup_provider.dart';
import 'package:provider/provider.dart';

class ScoresPanel extends StatefulWidget {
  final bool userLineup;
  const ScoresPanel({super.key, required this.userLineup});

  @override
  State<ScoresPanel> createState() => _ScoresPanelState();
}

class _ScoresPanelState extends State<ScoresPanel> {

  late BaseLineupProvider provider;

  @override
  void initState() {
    super.initState();
    if (widget.userLineup) {
      provider = context.read<LineupProvider>();
    } else {
      provider = context.read<OtherLineupProvider>();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(40, 30, 40, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Average
          Column(
            children: [
              Text(
                '${provider.avgRating}',
                style: TextStyle(
                  fontSize: 37,
                  color: Colors.greenAccent,
                ),
              ),
              Transform.translate(
                offset: Offset(0, -12),
                child: const Text(
                  'Average',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
            child: Column(
              children: [
                Text(
                  '${provider.lineupRating}',
                  style: TextStyle(
                    fontSize: 42,
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, -12),
                  child: const Text(
                    'Rating',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Highest
          Column(
            children: [
              Text(
                '${provider.maxRating}',
                style: TextStyle(
                  fontSize: 37,
                  color: Colors.greenAccent,
                ),
              ),
              Transform.translate(
                offset: Offset(0, -12),
                child: const Text(
                  'Highest',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}