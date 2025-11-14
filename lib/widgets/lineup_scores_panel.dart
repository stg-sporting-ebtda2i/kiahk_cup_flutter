import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/providers/base_lineup_provider.dart';

class ScoresPanel extends StatelessWidget {
  final BaseLineupProvider provider;

  const ScoresPanel({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black87,
            Colors.transparent,
          ],
        ),
      ),
      padding: EdgeInsets.only(top: 19, bottom: 32),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
        _buildChemistryTracker(),
        _buildRatingTracker(),
      ]),
    );
    // return Padding(
    //   padding: EdgeInsets.fromLTRB(40, 30, 40, 15),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       // Average
    //       Column(
    //         children: [
    //           Text(
    //             '${provider.avgRating}',
    //             style: TextStyle(
    //               fontSize: 37,
    //               color: Colors.greenAccent,
    //             ),
    //           ),
    //           Transform.translate(
    //             offset: Offset(0, -12),
    //             child: const Text(
    //               'Average',
    //               style: TextStyle(
    //                 fontSize: 17,
    //                 color: Colors.white,
    //                 fontWeight: FontWeight.w500,
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
    //         child: Column(
    //           children: [
    //             Text(
    //               '${provider.lineupRating}',
    //               style: TextStyle(
    //                 fontSize: 42,
    //                 color: Colors.greenAccent,
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //             Transform.translate(
    //               offset: Offset(0, -12),
    //               child: const Text(
    //                 'Rating',
    //                 style: TextStyle(
    //                   fontSize: 18,
    //                   color: Colors.white,
    //                   fontWeight: FontWeight.w500,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       // Highest
    //       Column(
    //         children: [
    //           Text(
    //             '${provider.maxRating}',
    //             style: TextStyle(
    //               fontSize: 37,
    //               color: Colors.greenAccent,
    //             ),
    //           ),
    //           Transform.translate(
    //             offset: Offset(0, -12),
    //             child: const Text(
    //               'Highest',
    //               style: TextStyle(
    //                 fontSize: 17,
    //                 color: Colors.white,
    //                 fontWeight: FontWeight.w500,
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }

  Widget _buildChemistryTracker() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'CHEMISTRY',
          style: TextStyle(
            fontSize: 15,
            color: Colors.white.withAlpha(200),
            fontWeight: FontWeight.w500,
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: 75,
              child: LinearProgressIndicator(
                value: 7 / 10,
                backgroundColor: Colors.grey,
                color: Color(0xFFFAD361),
                minHeight: 8,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              '7/10',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.9,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRatingTracker() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'RATING',
          style: TextStyle(
            fontSize: 15,
            color: Colors.white.withAlpha(200),
            fontWeight: FontWeight.w500,
          ),
        ),
        Row(
          children: [
            StarRatingProgress(rating: 4),
            SizedBox(
              width: 8,
            ),
            Text(
              '90',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.9,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class StarRatingProgress extends StatelessWidget {
  final double rating;
  final double maxRating;
  final int starCount;
  final double starSize;
  final Color filledColor;
  final Color emptyColor;

  const StarRatingProgress({
    super.key,
    required this.rating,
    this.maxRating = 5.0,
    this.starCount = 5,
    this.starSize = 20.0,
    this.filledColor = Colors.amber,
    this.emptyColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(starCount, (index) {
        double starValue = index + 1.0;
        bool isFilled = starValue <= rating;

        return isFilled ?
        Icon(
          Icons.star_rate_rounded,
          size: starSize,
          color: filledColor,
        ) : Icon(
          Icons.star_rate_rounded,
          size: starSize,
          color: emptyColor,
        );
      }),
    );
  }
}
