import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/widgets/card_placeholder.dart';

class EmptyPlayerCard extends StatelessWidget {
  final VoidCallback onClick;
  final double height;

  const EmptyPlayerCard({
    super.key,
    required this.onClick,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: SizedBox(
        width: 900*height/1266,
        height: height,
        // child: Image(
        //   image: AssetImage('assets/placeholder/card_placeholder2.png'),
        //   width: double.infinity,
        //   height: double.infinity,
        //   fit: BoxFit.fill,
        // ),
        child: CardPlaceholder(),
      ),
    );
  }
}