import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/providers/icons_store_provider.dart';
import 'package:piehme_cup_flutter/providers/lineup_provider.dart';
import 'package:piehme_cup_flutter/services/icons_service.dart';
import 'package:piehme_cup_flutter/utils/action_utils.dart';
import 'package:piehme_cup_flutter/widgets/iconstore_listitem.dart';
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
    return Container(
      color: Colors.black87,
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with title and close button
          Padding(
            padding: const EdgeInsets.only(left: 32, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Card',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white70),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 318,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: provider.items.length,
              itemBuilder: (context, index) {
                final item = provider.items[index];
                return Container(
                  width: 164, // Fixed width for each item
                  margin: const EdgeInsets.only(right: 16), // Spacing between items
                  child: IconStoreListItem(
                    imageUrl: item.imageUrl ?? '',
                    imageKey: item.imageKey ?? '',
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
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20), // Bottom padding
        ],
      ),
    );
  }
}