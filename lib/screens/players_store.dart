import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/providers/lineup_provider.dart';
import 'package:piehme_cup_flutter/providers/players_store_provider.dart';
import 'package:piehme_cup_flutter/services/players_service.dart';
import 'package:piehme_cup_flutter/utils/action_utils.dart';
import 'package:piehme_cup_flutter/widgets/header.dart';
import 'package:piehme_cup_flutter/widgets/store_listitem.dart';
import 'package:provider/provider.dart';

class PlayersStorePage extends StatefulWidget {
  const PlayersStorePage({super.key, required this.position});

  final String position;

  @override
  State<PlayersStorePage> createState() => _PlayersStorePageState();
}

class _PlayersStorePageState extends State<PlayersStorePage> {

  @override
  void initState() {
    super.initState();
      context.read<PlayersStoreProvider>().loadStore(widget.position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Image(
            image: AssetImage('assets/other_background.png'),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Consumer<PlayersStoreProvider>(
            builder: (context, provider, child) {
              return Column(
                children: [
                  SafeArea(child: Header()),
                  Visibility(
                    visible: provider.items.isNotEmpty || !provider.isLoaded,
                    replacement: Container(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        "No players available for position ${widget.position}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    child: Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 0.45,
                        ),
                        padding: const EdgeInsets.all(15),
                        itemCount: provider.items.length,
                        itemBuilder: (context, index) {
                          final item = provider.items[index];
                          return StoreListItem(
                            imageUrl: item.imageUrl,
                            imageKey: item.imageKey,
                            price: item.price,
                            owned: item.owned,
                            selected: false,
                            buy: () => ActionUtils(
                              context: context,
                              action: () => PlayersService.buyPlayer(item.id),
                              callback: () {
                                context.read<LineupProvider>().loadUserData();
                                Navigator.pop(context);
                              }).confirmAction(),
                            sell: () => ActionUtils(
                                context: context,
                                action: () => PlayersService.sellPlayer(item.id),
                                callback: () {
                                  context.read<LineupProvider>().loadUserData();
                                  Navigator.pop(context);
                                }).confirmAction(),
                            select: () {Navigator.pop(context);},
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
          ),
        ],
      ),
    );
  }
}