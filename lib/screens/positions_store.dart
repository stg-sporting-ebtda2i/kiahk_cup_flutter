import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/providers/positions_store_provider.dart';
import 'package:piehme_cup_flutter/services/positions_service.dart';
import 'package:piehme_cup_flutter/utils/action_utils.dart';
import 'package:piehme_cup_flutter/widgets/header.dart';
import 'package:piehme_cup_flutter/widgets/position_store_listitem.dart';
import 'package:provider/provider.dart';

class PositionsStorePage extends StatefulWidget {
  const PositionsStorePage({super.key});

  @override
  State<PositionsStorePage> createState() => _PositionsStorePageState();
}

class _PositionsStorePageState extends State<PositionsStorePage> {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PositionsStoreProvider>(context);
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
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1,
                  ),
                  padding: const EdgeInsets.all(15),
                  itemCount: provider.items.length,
                  itemBuilder: (context, index) {
                    final item = provider.items[index];
                    return PositionListItem(
                      item: item,
                      buy: () => ActionUtils(
                        delay: 0,
                          context: context,
                          action: () => PositionsService.buyPosition(item.id),
                          callback: () {
                            // provider.loadStore();
                          }
                      ).confirmAction(),
                      sell: () => ActionUtils(
                        delay: 0,
                          context: context,
                          action: () => PositionsService.sellPosition(item.id),
                          callback: () {
                            // provider.loadStore();
                          }
                      ).confirmAction(),
                      select: () => ActionUtils(
                        delay: 0,
                          context: context,
                          action: () => PositionsService.selectPosition(item.id),
                          callback: () {
                            // provider.loadStore();
                          }
                      ).confirmAction(),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}