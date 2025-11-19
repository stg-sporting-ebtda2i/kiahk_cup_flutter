import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/dialogs/loading.dart';
import 'package:piehme_cup_flutter/providers/lineup_provider.dart';
import 'package:piehme_cup_flutter/providers/positions_store_provider.dart';
import 'package:piehme_cup_flutter/services/positions_service.dart';
import 'package:piehme_cup_flutter/utils/action_utils.dart';
import 'package:piehme_cup_flutter/widgets/animated_list_item.dart';
import 'package:piehme_cup_flutter/widgets/header.dart';
import 'package:piehme_cup_flutter/widgets/position_store_listitem.dart';
import 'package:provider/provider.dart';

class PositionsStorePage extends StatefulWidget {
  const PositionsStorePage({super.key});

  @override
  State<PositionsStorePage> createState() => _PositionsStorePageState();
}

class _PositionsStorePageState extends State<PositionsStorePage> {
  late PositionsStoreProvider provider;
  late LineupProvider lineupProvider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<PositionsStoreProvider>(context);
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
                  'Position',
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
          // Horizontal scroll view
          SizedBox(
            height: 162,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: provider.items.length,
              itemBuilder: (context, index) {
                final item = provider.items[index];
                return Container(
                  width: 164, // Fixed width for each item
                  margin: const EdgeInsets.only(right: 16), // Spacing between items
                  child: AnimatedListItem(
                    index: index,
                    child: PositionListItem(
                      item: item,
                      buy: () => ActionUtils(
                          delay: 0,
                          context: context,
                          action: () => PositionsService.buyPosition(item.id),
                          callback: () async {
                            await provider.loadStore();
                            await lineupProvider.loadLineup(-1);
                          }
                      ).confirmAction(),
                      sell: () => ActionUtils(
                          delay: 0,
                          context: context,
                          action: () => PositionsService.sellPosition(item.id),
                          callback: () async {
                            await provider.loadStore();
                            await lineupProvider.loadLineup(-1);
                          }
                      ).confirmAction(),
                      select: () => ActionUtils(
                          delay: 0,
                          context: context,
                          action: () => PositionsService.selectPosition(item.id),
                          callback: () async {
                            await provider.loadStore();
                            await lineupProvider.loadLineup(-1);
                          }
                      ).confirmAction(),
                    ),
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