import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/models/player.dart';
import 'package:piehme_cup_flutter/providers/lineup_provider.dart';
import 'package:piehme_cup_flutter/services/players_service.dart';
import 'package:piehme_cup_flutter/utils/action_utils.dart';
import 'package:piehme_cup_flutter/widgets/empty_player_card.dart';
import 'package:piehme_cup_flutter/widgets/player_card.dart';
import 'package:piehme_cup_flutter/widgets/user_card.dart';
import 'package:provider/provider.dart';

import '../routes/app_routes.dart';

class CardsUtils {

  static Widget getCard({
    required String position,
    required BuildContext context,
    required double cardHeight,
    required bool clickable,
  }) {
    LineupProvider provider = Provider.of<LineupProvider>(context);
    if (position == provider.user.position && !provider.userCardUsed) {
      provider.userCardUsed = true;
      return SizedBox(
        width: 559 * cardHeight / 800,
        height: cardHeight,
        child: UserCard(
          width: 559 * cardHeight / 800,
          user: provider.user,
        ),
      );
    } else {
      Player? player = provider.getNextPlayer(position);
      if (player != null) {
        return PlayerCard(
          player: player,
          height: cardHeight,
          onClick: clickable ? () =>
              ActionUtils(
                  context: context,
                  action: () => PlayersService.sellPlayer(player.id),
                  callback: () {
                    context.read<LineupProvider>().loadLineup();
                  }).confirmAction() : () {},
        );
      } else {
        return EmptyPlayerCard(
          height: cardHeight,
          onClick: clickable ? () {
            Navigator.pushNamed(context, AppRoutes.playersStore,
                arguments: {'position': position});
          } : () {},
        );
      }
    }
  }

}