import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/dialogs/message.dart';
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
        width: 900 * cardHeight / 1266,
        height: cardHeight,
        child: UserCard(
          width: 900 * cardHeight / 1266,
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
                  action: () async {
                    await PlayersService.sellPlayer(player.id);

                    toast("${player.name} has been sold");
                  },
                  callback: () {
                    context.read<LineupProvider>().loadUserData();
                  }).confirmAction(text: "Are you sure you want to sell ${player.name}?", confirmBtn: "Sell") : () {},
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