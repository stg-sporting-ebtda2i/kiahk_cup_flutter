import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/dialogs/loading.dart';
import 'package:piehme_cup_flutter/dialogs/message.dart';
import 'package:piehme_cup_flutter/models/player.dart';
import 'package:piehme_cup_flutter/providers/lineup_provider.dart';
import 'package:piehme_cup_flutter/providers/players_store_provider.dart';
import 'package:piehme_cup_flutter/services/players_service.dart';
import 'package:piehme_cup_flutter/utils/action_utils.dart';
import 'package:piehme_cup_flutter/widgets/empty_player_card.dart';
import 'package:piehme_cup_flutter/widgets/player_card.dart';
import 'package:piehme_cup_flutter/widgets/user_card.dart';
import 'package:provider/provider.dart';

import '../providers/base_lineup_provider.dart';
import '../routes/app_routes.dart';

class CardsUtils {

  static Widget getCard({
    required String position,
    required BuildContext context,
    required double cardHeight,
    required bool clickable,
    required BaseLineupProvider provider,
  }) {
    if (position == provider.user.position && !provider.userCardUsed) {
      provider.userCardUsed = true;
      return Hero(
        tag: "user-card",
        child: SizedBox(
          width: 900 * cardHeight / 1266,
          height: cardHeight,
          child: UserCard(
            width: 900 * cardHeight / 1266,
            user: provider.user,
            onClick: () {
              Navigator.pushNamed(context, AppRoutes.userCard);
            },
          ),
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
                  delay: 0,
                  action: () async {
                    await PlayersService.sellPlayer(player.id);
                    toast("${player.name} has been sold");
                  },
                  // callback: DataUtils.playersStoreCallback(context),
                callback: () async {await context.read<LineupProvider>().loadLineup(-1);},
              ).confirmAction(text: "Are you sure you want to sell ${player.name}?", confirmBtn: "Sell") : () {},
        );
      } else {
        return EmptyPlayerCard(
          height: cardHeight,
          onClick: clickable ? () {
            PlayersStoreProvider provider = context.read<PlayersStoreProvider>();
            provider.loadStore(position);
            if (!context.mounted) return;
            Navigator.pushNamed(context, AppRoutes.playersStore,
                arguments: {'position': position});
          } : () {},
        );
      }
    }
  }

}