import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/models/Position.dart';

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
        SizedBox(
          width: 115,
          height: 37,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white70,
            ),
            child: Text(
              item.purchased?'Select':'Purchase',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}