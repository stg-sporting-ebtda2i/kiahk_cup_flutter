import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/providers/lineup_provider.dart';
import 'package:piehme_cup_flutter/providers/players_store_provider.dart';
import 'package:piehme_cup_flutter/services/players_service.dart';
import 'package:piehme_cup_flutter/utils/action_utils.dart';
import 'package:piehme_cup_flutter/widgets/header.dart';
import 'package:piehme_cup_flutter/widgets/player_store_listitem.dart';
import 'package:provider/provider.dart';

class PlayersStorePage extends StatefulWidget {
  const PlayersStorePage({super.key, required this.position});

  final String position;

  @override
  State<PlayersStorePage> createState() => _PlayersStorePageState();
}

class _PlayersStorePageState extends State<PlayersStorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF054127),
              Color(0xFF032C28),
              Color(0xFF021C29),
              Color(0xFF250D1B),
              Color(0xFF50121F),
            ],
          ),
        ),
        child: Consumer<PlayersStoreProvider>(builder: (context, provider, child) {
          return Column(
            children: [
              SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 26),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black87,
                        Colors.black45,
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 4, 0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Store',
                          style: const TextStyle(
                            fontSize: 23,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Header(),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: provider.items.isNotEmpty || !provider.isLoaded,
                replacement: _buildEmptyPositionWidget(),
                child: Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: provider.items.length,
                    itemBuilder: (context, index) {
                      final item = provider.items[index];
                      return PlayerStoreListItem(
                        index: index,
                        player: item,
                        owned: item.owned,
                        selected: item.owned,
                        buy: () => ActionUtils(
                          delay: 0,
                          context: context,
                          action: () => PlayersService.buyPlayer(item.id),
                          callback: () async {
                            await context
                                .read<LineupProvider>()
                                .loadLineup(-1);
                            if (!context.mounted) return;
                            Navigator.pop(context);
                          },
                        ).confirmAction(),
                        sell: () => ActionUtils(
                          delay: 0,
                          context: context,
                          action: () => PlayersService.sellPlayer(item.id),
                          callback: () async {
                            await context
                                .read<LineupProvider>()
                                .loadLineup(-1);
                            if (!context.mounted) return;
                            Navigator.pop(context);
                          },
                        ).confirmAction(),
                        select: () {
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildEmptyPositionWidget() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      margin: EdgeInsets.only(left: 8, right: 8),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(100), // More transparent
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withAlpha(25),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(77),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(25),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.sports_soccer_rounded,
              size: 50,
              color: Colors.grey.shade300,
            ),
          ),
          SizedBox(height: 16),
          Text(
            "No Players Available",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(25),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "${widget.position} Position",
              style: TextStyle(
                color: Colors.grey.shade300,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 12),
          Text(
            "Check back later for new players\nin this position",
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 14,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

}
