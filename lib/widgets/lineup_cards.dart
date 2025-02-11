import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/widgets/user_card.dart';
import 'package:piehme_cup_flutter/widgets/lineup_card.dart';

class Lineup extends StatefulWidget {
  final bool userLineup;
  const Lineup({super.key, required this.userLineup});

  @override
  State<Lineup> createState() => _LineupState();
}

class _LineupState extends State<Lineup> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Front Row (LW, ST, RW)
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PlayerIcon(id: 'LW', userLineup: widget.userLineup),
              Transform.translate(
                offset: Offset(0, -40),
                child: PlayerIcon(id: 'ST', userLineup: widget.userLineup),
              ),
              PlayerIcon(id: 'RW', userLineup: widget.userLineup),
            ],
          ),
        ),
        // Back Row (LCM, CAM, RCM)
        Padding(
          padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PlayerIcon(id: 'LCM', userLineup: widget.userLineup),
              Transform.translate(
                offset: Offset(0, -30),
                child: PlayerIcon(id: 'CAM', userLineup: widget.userLineup),
              ),
              PlayerIcon(id: 'RCM', userLineup: widget.userLineup),
            ],
          ),
        ),
        // Center Row (LB, LCB, RCB, RB)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PlayerIcon(id: 'LB', userLineup: widget.userLineup),
            PlayerIcon(id: 'LCB', userLineup: widget.userLineup),
            PlayerIcon(id: 'RCB', userLineup: widget.userLineup),
            PlayerIcon(id: 'RB', userLineup: widget.userLineup),
          ],
        ),
        // Goalkeeper (GK)
        SizedBox(
          width: 95,
          height: 136,
          child: PlayerCard(
            width: 95,
            name: 'Patrick Remon',
            rating: 99,
            iconURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/CardIcons%2Ficon0.png?alt=media&token=926b31d4-7b75-4f57-ba28-28a78066628d',
            image: null,
            imageURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/Users%2Fauto.png?alt=media&token=575a019d-e553-4be5-af05-8c50af82fdf4',
            position: 'ST',
          ),
        )
      ],
    );
  }
}