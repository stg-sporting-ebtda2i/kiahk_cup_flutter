import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/models/player.dart';
import 'package:piehme_cup_flutter/providers/lineup_provider.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';
import 'package:piehme_cup_flutter/services/players_service.dart';
import 'package:piehme_cup_flutter/utils/action_utils.dart';
import 'package:piehme_cup_flutter/widgets/empty_player_card.dart';
import 'package:piehme_cup_flutter/widgets/player_card.dart';
import 'package:piehme_cup_flutter/widgets/user_card.dart';
import 'package:provider/provider.dart';

class CardsUtils {

  static Widget getCard({
    required String position,
    required BuildContext context,
    required double cardHeight,
    required bool clickable,
  }) {
    LineupProvider provider = Provider.of<LineupProvider>(context);
    if (position == provider.userPosition.name) {
      return SizedBox(
        width: 559*cardHeight/800,
        height: cardHeight,
        child: UserCard(
          width: 559*cardHeight/800,
          name: 'Patrick Remon',
          rating: 99,
          iconURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/CardIcons%2Ficon0.png?alt=media&token=926b31d4-7b75-4f57-ba28-28a78066628d',
          image: null,
          imageURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/Users%2Fauto.png?alt=media&token=575a019d-e553-4be5-af05-8c50af82fdf4',
          position: 'ST',
          empty: false,
        ),
      );
    }
    try {
      Player p = provider.lineup.firstWhere((player) => player.position == position);
      return PlayerCard(
          player: p,
          height: cardHeight,
          onClick: clickable ? () => ActionUtils(
              context: context,
              action: () => PlayersService.sellPlayer(p.playerId),
              callback: () {
                context.read<LineupProvider>().loadLineup();
              }).confirmAction() : () {},
      );
    } catch (e) {
      return EmptyPlayerCard(
        height: cardHeight,
        onClick: clickable ? () {
          Navigator.pushNamed(context, AppRoutes.playersStore, arguments: {'position': position});
        } : () {},
      );
    }
  }

}