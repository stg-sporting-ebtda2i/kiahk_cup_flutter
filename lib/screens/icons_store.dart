import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/dialogs/loading.dart';
import 'package:piehme_cup_flutter/providers/icons_store_provider.dart';
import 'package:piehme_cup_flutter/providers/lineup_provider.dart';
import 'package:piehme_cup_flutter/services/icons_service.dart';
import 'package:piehme_cup_flutter/utils/action_utils.dart';
import 'package:piehme_cup_flutter/widgets/header.dart';
import 'package:piehme_cup_flutter/widgets/store_listitem.dart';
import 'package:provider/provider.dart';

class IconsStorePage extends StatefulWidget {
  const IconsStorePage({super.key});

  @override
  State<IconsStorePage> createState() => _IconsStorePageState();
}

class _IconsStorePageState extends State<IconsStorePage> {

  late IconsStoreProvider provider;
  late LineupProvider lineupProvider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<IconsStoreProvider>(context);
    lineupProvider = Provider.of<LineupProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          const Image(
            image: AssetImage('assets/other_background.png'),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Column(
            children: [
              SafeArea(child: Header()),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await Loading.show(() async {
                      await provider.loadStore();
                    }, delay: Duration(milliseconds: 0));
                  },
                  color: Colors.black,
                  backgroundColor: Colors.greenAccent,
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.54,
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
                        selected: item.selected,
                        buy: () => ActionUtils(
                          delay: 0,
                          context: context,
                          action: () => IconsService.buyIcon(item.id),
                          callback: () async {
                            await provider.loadStore();
                            await lineupProvider.loadLineup(-1);
                          }).confirmAction(),
                        sell: () => ActionUtils(
                          delay: 0,
                            context: context,
                            action: () => IconsService.sellIcon(item.id),
                            callback: () async {
                              await provider.loadStore();
                              await lineupProvider.loadLineup(-1);
                            }).confirmAction(),
                        select: () => ActionUtils(
                          delay: 0,
                            context: context,
                            action: () => IconsService.selectIcon(item.id),
                            callback: () async {
                              await provider.loadStore();
                              await lineupProvider.loadLineup(-1);
                            }).confirmAction(),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}