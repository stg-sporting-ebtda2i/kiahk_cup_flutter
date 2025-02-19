import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/providers/lineup_provider.dart';
import 'package:provider/provider.dart';

class ScoresPanel extends StatefulWidget {
  const ScoresPanel({super.key});

  @override
  State<ScoresPanel> createState() => _ScoresPanelState();
}

class _ScoresPanelState extends State<ScoresPanel> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LineupProvider>(context);
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