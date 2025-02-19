import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/providers/lineup_provider.dart';
import 'package:piehme_cup_flutter/utils/card_utils.dart';
import 'package:provider/provider.dart';

class Lineup extends StatefulWidget {

  final bool userLineup;
  final int userID;

  const Lineup({
    super.key,
    required this.userLineup,
    required this.userID,
  });

  @override
  State<Lineup> createState() => _LineupState();
}

class _LineupState extends State<Lineup> {

  late double _cardHeight;

  @override
  void initState() {
    super.initState();
    if (widget.userLineup) {
      context.read<LineupProvider>().loadLineup();
      context.read<LineupProvider>().loadUserCard();
    } else {
      context.read<LineupProvider>().loadOtherLineup(widget.userID);
      context.read<LineupProvider>().loadOtherUserCard(widget.userID);
    }
  }

  @override
  Widget build(BuildContext context) {
    _cardHeight = MediaQuery.of(context).size.height/6.7;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Front Row (LW, ST, RW)
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardsUtils.getCard(
                context: context,
                cardHeight: _cardHeight,
                clickable: widget.userLineup,
                position: 'LW'
              ),
              Transform.translate(
                offset: Offset(0, -40),
                child: CardsUtils.getCard(
                    context: context,
                    cardHeight: _cardHeight,
                    clickable: widget.userLineup,
                    position: 'ST'
                ),
              ),
              CardsUtils.getCard(
                  context: context,
                  cardHeight: _cardHeight,
                  clickable: widget.userLineup,
                  position: 'RW'
              ),
            ],
          ),
        ),
        // Back Row (LCM, CAM, RCM)
        Padding(
          padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardsUtils.getCard(
                  context: context,
                  cardHeight: _cardHeight,
                  clickable: widget.userLineup,
                  position: 'CM'
              ),
              Transform.translate(
                offset: Offset(0, -30),
                child: CardsUtils.getCard(
                    context: context,
                    cardHeight: _cardHeight,
                    clickable: widget.userLineup,
                    position: 'CAM'
                ),
              ),
              CardsUtils.getCard(
                  context: context,
                  cardHeight: _cardHeight,
                  clickable: widget.userLineup,
                  position: 'CM'
              ),
            ],
          ),
        ),
        // Center Row (LB, LCB, RCB, RB)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CardsUtils.getCard(
                context: context,
                cardHeight: _cardHeight,
                clickable: widget.userLineup,
                position: 'LB'
            ),
            CardsUtils.getCard(
                context: context,
                cardHeight: _cardHeight,
                clickable: widget.userLineup,
                position: 'CB'
            ),
            CardsUtils.getCard(
                context: context,
                cardHeight: _cardHeight,
                clickable: widget.userLineup,
                position: 'CB'
                    ''),
            CardsUtils.getCard(
                context: context,
                cardHeight: _cardHeight,
                clickable: widget.userLineup,
                position: 'RB'
            ),
          ],
        ),
        // Goalkeeper (GK)
        CardsUtils.getCard(
            context: context,
            cardHeight: _cardHeight,
            clickable: widget.userLineup,
            position: 'GK'
        ),
      ],
    );
  }
}