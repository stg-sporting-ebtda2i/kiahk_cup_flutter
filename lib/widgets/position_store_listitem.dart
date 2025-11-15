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
        Center(
          child: Text(
            item.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 39,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              item.price,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 8,),
            Image.asset(
              'assets/icons/coin.png',
              width: 20,
              height: 20,
              fit: BoxFit.cover,
            ),
          ],
        ),
        SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (item.owned) SizedBox(width: 30,),
            SizedBox(
              height: 35,
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
                width: 27,
                child: IconButton(
                  onPressed: sell,
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.red,
                    size: 27,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}