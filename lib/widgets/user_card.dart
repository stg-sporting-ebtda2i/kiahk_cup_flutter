import 'dart:io';

import 'package:flutter/material.dart';

class PlayerCard extends StatelessWidget {
  final double width;
  const PlayerCard({
    super.key,
    required this.width,
    this.image,
    this.imageURL,
    required this.name,
    required this.position,
    required this.rating,
    required this.iconURL});

  final File? image;
  final String? imageURL;
  final String name;
  final String position;
  final int rating;
  final String iconURL;

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
              Image.network(
                iconURL,
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
                child: image != null ? Image.file(image!, fit: BoxFit.cover,) : Image.network(
                  imageURL!,
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
                    name,
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
                  position,
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
                  '$rating',
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