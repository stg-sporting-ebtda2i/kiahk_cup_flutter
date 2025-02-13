import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:piehme_cup_flutter/dialogs/alert_dialog.dart';
import 'package:piehme_cup_flutter/dialogs/toast_error.dart';
import 'package:piehme_cup_flutter/models/player.dart';
import 'package:piehme_cup_flutter/services/players_service.dart';
import 'package:piehme_cup_flutter/widgets/empty_player_card.dart';
import 'package:piehme_cup_flutter/widgets/user_card.dart';
import 'package:piehme_cup_flutter/widgets/player_card.dart';

class Lineup extends StatefulWidget {
  final bool userLineup;
  const Lineup({super.key, required this.userLineup});

  @override
  State<Lineup> createState() => _LineupState();
}

class _LineupState extends State<Lineup> {

  late List<Player> _lineup = <Player>[];
  late double _cardHeight;

  @override
  void initState() {
    super.initState();
    _loadLineup();
  }

  Future<void> _loadLineup() async {
    EasyLoading.show(status: 'Loading...');
    List<Player> lineup = <Player>[];
    try {
      lineup = await PlayersService.getLineup();
      setState(() {
        _lineup = lineup;
      });
    } catch (e) {
      toastError(e.toString());
    } finally {
      EasyLoading.dismiss(animation: true);
    }
  }

  void _confirmSell(Future<void> action, String operation) {
    showAlertDialog(
        context: context,
        text: 'Are you sure that you want to $operation this icon?',
        positiveBtnText: 'Confirm',
        positiveBtnAction: () {
          _performSell(action);
          Navigator.pop(context);
        },
        negativeBtnText: 'Cancel',
        negativeBtnAction: () {Navigator.pop(context);}
    );
  }

  void _performSell(Future<void> action) async {
    EasyLoading.show(status: 'Loading...');
    try {
      await action;
    } catch(e) {
      toastError(e.toString());
    } finally {
      EasyLoading.dismiss(animation: true);
      _loadLineup();
    }
  }

  Widget getPlayer({
    required String position
  }) {
    // if (position == user position) return his card
    try {
      Player p = _lineup.firstWhere((player) => player.position == position);
      return PlayerCard(
        player: p,
        userLineup:widget.userLineup,
        height: _cardHeight,
        onClick: () => _confirmSell(PlayersService.sellPlayer(p.playerId), 'Sell')
      );
    } catch (e) {
      return EmptyPlayerCard(
        position: position,
        userLineup: widget.userLineup,
        height: _cardHeight,
        lineupContext: context,
      );
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
              getPlayer(position: 'LW'),
              Transform.translate(
                offset: Offset(0, -40),
                child: getPlayer(position: 'ST'),
              ),
              getPlayer(position: 'RW'),
            ],
          ),
        ),
        // Back Row (LCM, CAM, RCM)
        Padding(
          padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getPlayer(position: 'LCM'),
              Transform.translate(
                offset: Offset(0, -30),
                child: getPlayer(position: 'CAM'),
              ),
              getPlayer(position: 'RCM'),
            ],
          ),
        ),
        // Center Row (LB, LCB, RCB, RB)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            getPlayer(position: 'LB'),
            getPlayer(position: 'LCB'),
            getPlayer(position: 'RCB'),
            getPlayer(position: 'RB'),
          ],
        ),
        // Goalkeeper (GK)
        SizedBox(
          width: 559*_cardHeight/800,
          height: _cardHeight,
          child: UserCard(
            width: 559*_cardHeight/800,
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