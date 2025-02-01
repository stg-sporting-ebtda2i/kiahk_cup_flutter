import 'package:flutter/material.dart';
import 'player_card.dart';

class LineupPage extends StatelessWidget {
  const LineupPage({super.key});

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
                child: Lineup(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScoresPanel extends StatelessWidget {
  const ScoresPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(40, 70, 40, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Average
          Column(
            children: [
              Text(
                '33',
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
                  '5',
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
                '97', // Replace with dynamic value
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

class Lineup extends StatelessWidget {
  const Lineup({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Front Row (LW, ST, RW)
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PlayerIcon(id: 'LW'),
                Transform.translate(
                  offset: Offset(0, -40),
                    child: PlayerIcon(id: 'ST'),
                ),
                PlayerIcon(id: 'RW'),
              ],
            ),
          ),
          // Back Row (LCM, CAM, RCM)
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PlayerIcon(id: 'LCM'),
                Transform.translate(
                  offset: Offset(0, -30),
                  child: PlayerIcon(id: 'CAM'),
                ),
                PlayerIcon(id: 'RCM'),
              ],
            ),
          ),
          // Center Row (LB, LCB, RCB, RB)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PlayerIcon(id: 'LB'),
              PlayerIcon(id: 'LCB'),
              PlayerIcon(id: 'RCB'),
              PlayerIcon(id: 'RB'),
            ],
          ),
          // Goalkeeper (GK)
          SizedBox(
            width: 95,
            height: 136,
            child: PlayerCard(width: 95),
          )
        ],
      ),
    );
  }
}

class PlayerIcon extends StatelessWidget {
  final String id;

  const PlayerIcon({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95,
      height: 136,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/icon0.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}