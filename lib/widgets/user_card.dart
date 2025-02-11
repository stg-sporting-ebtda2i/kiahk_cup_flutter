import 'package:flutter/material.dart';

class PlayerCard extends StatelessWidget {
  final double width;
  const PlayerCard({super.key, required this.width});

  // Card Size: H=800px, W=559px.

  @override
  Widget build(BuildContext context) {
    final cardWidth = width;
    final cardHeight = cardWidth * (800 / 559);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SizedBox(
          width: cardWidth,
          height: cardHeight,
          child: Stack(
            children: [
              // Card Icon (Background Image)
              Image.asset(
                'assets/icon0.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              // Centered Image
              Positioned(
                top: cardHeight * (20 / 100),
                left: cardWidth * (20 / 100),
                right: cardWidth * (20 / 100),
                bottom: cardHeight * (30 / 100),
                child: Image.asset(
                  'assets/auto.png',
                  fit: BoxFit.cover,
                ),
              ),
              // Name Text
              Positioned(
                top: cardHeight * (72 / 100),
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    'Patrick Remon',
                    style: TextStyle(
                      fontSize: cardWidth * (9 / 100),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Position Text
              Positioned(
                top: cardHeight * (22 / 100),
                left: cardWidth * (17 / 100),
                child: Text(
                  'ST',
                  style: TextStyle(
                    fontSize: cardWidth * (6 / 100),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // Card Rating Text
              Positioned(
                top: cardHeight * (12 / 100),
                left: cardWidth * (14 / 100),
                child: Text(
                  '97',
                  style: TextStyle(
                    fontSize: cardWidth * (11 / 100),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}