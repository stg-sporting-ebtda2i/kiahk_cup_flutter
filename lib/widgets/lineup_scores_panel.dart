import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/providers/base_lineup_provider.dart';

class ScoresPanel extends StatelessWidget {

  final BaseLineupProvider provider;

  const ScoresPanel({super.key, required this.provider});

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