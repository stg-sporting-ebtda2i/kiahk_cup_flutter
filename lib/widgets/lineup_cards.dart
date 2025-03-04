import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/providers/base_lineup_provider.dart';
import 'package:piehme_cup_flutter/providers/buttons_visibility_provider.dart';
import 'package:piehme_cup_flutter/providers/lineup_provider.dart';
import 'package:piehme_cup_flutter/providers/other_lineup_provider.dart';
import 'package:piehme_cup_flutter/utils/card_utils.dart';
import 'package:provider/provider.dart';

class Lineup extends StatefulWidget {

  final bool userLineup;

  const Lineup({
    super.key,
    required this.userLineup,
  });

  @override
  State<Lineup> createState() => _LineupState();
}

class _LineupState extends State<Lineup> {

  late double _cardHeight;
  late bool _storeOpened = false;
  late BaseLineupProvider _provider;

  @override
  void initState() {
    super.initState();
    _storeOpened = context.read<ButtonsVisibilityProvider>().isVisible('Store');
    if (widget.userLineup) {
      _provider = context.read<LineupProvider>();
    } else {
      _provider = context.read<OtherLineupProvider>();
    }
    _provider.resetAddedCards();
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
              getCard('LW'),
              Transform.translate(
                offset: Offset(0, -40),
                child: getCard('ST'),
              ),
              getCard('RW'),
            ],
          ),
        ),
        // Back Row (LCM, CAM, RCM)
        Padding(
          padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getCard('CM'),
              Transform.translate(
                offset: Offset(0, -30),
                child: getCard('CAM'),
              ),
              getCard('CM'),
            ],
          ),
        ),
        // Center Row (LB, LCB, RCB, RB)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            getCard('LB'),
            getCard('CB'),
            getCard('CB'),
            getCard('RB'),
          ],
        ),
        // Goalkeeper (GK)
        getCard('GK'),
      ],
    );
  }

  Widget getCard(String position) {
    return widget.userLineup ? Selector<LineupProvider, String?>(
      selector: (context, provider) => (provider.checkChangedData(position)),
      builder: (context, player, child) {
        return player!=null ?
        CardsUtils.getCard(
          context: context,
          cardHeight: _cardHeight,
          clickable: widget.userLineup && _storeOpened,
          position: position,
          provider: _provider,
        ) : SizedBox();
      },
    ) : Selector<OtherLineupProvider, String?>(
    selector: (context, provider) => (provider.checkChangedData(position)),
    builder: (context, player, child) {
    return player!=null ?
    CardsUtils.getCard(
    context: context,
    cardHeight: _cardHeight,
    clickable: widget.userLineup && _storeOpened,
    position: position,
    provider: _provider,
    ) : SizedBox();
    },
    );
  }

}