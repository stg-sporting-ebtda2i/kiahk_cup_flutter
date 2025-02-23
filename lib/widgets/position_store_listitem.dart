import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/models/position.dart';

class PositionListItem extends StatelessWidget {

  final Position item;
  final VoidCallback buy;
  final VoidCallback sell;
  final VoidCallback select;

  const PositionListItem({
    super.key,
    required this.item,
    required this.buy,
    required this.sell,
    required this.select
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
              item.name,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (item.owned) SizedBox(width: 30,),
            SizedBox(
              height: 37,
              child: ElevatedButton(
                onPressed: item.owned ? !item.selected ? select : () {} : buy,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white70,
                ),
                child: Text(
                  item.owned ? item.selected ? 'Selected' : 'Select' : 'Purchase',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            if (item.owned)
              SizedBox(
                width: 30,
                child: IconButton(
                  onPressed: sell,
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}