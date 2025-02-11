import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/models/Position.dart';
import 'package:piehme_cup_flutter/widgets/header.dart';
import 'package:piehme_cup_flutter/widgets/position_store_listitem.dart';

class PositionsStorePage extends StatefulWidget {
  const PositionsStorePage({super.key});

  @override
  State<PositionsStorePage> createState() => _PositionsStorePageState();
}

class _PositionsStorePageState extends State<PositionsStorePage> {

  late List<Position> _items;

  @override
  void initState() {
    super.initState();
    _loadPositionStore();
  }

  void _loadPositionStore() {
    _items = <Position>[
      Position(name: "GK", price: 0, purchased: true),
      Position(name: "LB", price: 80, purchased: false),
      Position(name: "RB", price: 80, purchased: true),
      Position(name: "CB", price: 75, purchased: false),
      Position(name: "CM", price: 90, purchased: true),
      Position(name: "CAM", price: 95, purchased: false),
      Position(name: "LW", price: 100, purchased: true),
      Position(name: "RW", price: 100, purchased: false),
      Position(name: "ST", price: 110, purchased: true),
    ];
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
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return PositionListItem(item: item);
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