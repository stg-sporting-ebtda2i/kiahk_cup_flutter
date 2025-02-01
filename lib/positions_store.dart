import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/header.dart';

class Position {
  final String name;
  final int price;
  final bool purchased;

  const Position({
    required this.name,
    required this.price,
    required this.purchased,
  });
}

class PositionsStorePage extends StatefulWidget {
  PositionsStorePage({super.key});

  List<Position> items = <Position>[
    new Position(name: "GK", price: 0, purchased: true),
    new Position(name: "LB", price: 80, purchased: false),
    new Position(name: "RB", price: 80, purchased: true),
    new Position(name: "CB", price: 75, purchased: false),
    new Position(name: "CM", price: 90, purchased: true),
    new Position(name: "CAM", price: 95, purchased: false),
    new Position(name: "LW", price: 100, purchased: true),
    new Position(name: "RW", price: 100, purchased: false),
    new Position(name: "ST", price: 110, purchased: true),
  ];

  @override
  State<PositionsStorePage> createState() => _PositionsStorePageState();
}

class _PositionsStorePageState extends State<PositionsStorePage> {

  late List<Position> _items;

  @override
  void initState() {
    super.initState();
    _items = widget.items;
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

class PositionListItem extends StatelessWidget {

  final Position item;

  const PositionListItem({
    super.key,
    required this.item
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 160,
          height: 80,
          child: Center(
            child: Text(
              '${item.name}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 39,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Text(
          '${item.price} €',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 5,),
        SizedBox(
          width: 115,
          height: 37,
          child: ElevatedButton(
            onPressed: () {},
            child: Text(
              item.purchased?'Select':'Purchase',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white70,
            ),
          ),
        ),
      ],
    );
  }
}
