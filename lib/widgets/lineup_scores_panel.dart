import 'dart:async';

import 'package:flutter/material.dart';

class ScoresPanel extends StatefulWidget {
  const ScoresPanel({super.key});

  @override
  State<ScoresPanel> createState() => _ScoresPanelState();
}

class _ScoresPanelState extends State<ScoresPanel> {
  int average = 0;
  int rating = 0;
  int highest = 0;
  // Timer? _timer;

  @override
  void initState() {
    super.initState();
    _updateScores();
    // _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    //   _updateScores();
    // });
  }

  // @override
  // void dispose() {
  //   _timer?.cancel();
  //   super.dispose();
  // }

  void _updateScores() {
    setState(() {
      average++;
      rating++;
      highest++;
    });
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
                '$average',
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
                  '$rating',
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
                '$highest',
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