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
          name: provider.user.name,
          rating: provider.user.cardRating,
          iconURL: provider.user.iconImgLink,
          image: null,
          imageURL: provider.user.userImgLink,
          position: provider.user.position,
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