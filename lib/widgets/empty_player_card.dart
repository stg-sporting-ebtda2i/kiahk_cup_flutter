import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';

class EmptyPlayerCard extends StatelessWidget {
  final String position;
  final bool userLineup;
  final double height;
  final BuildContext lineupContext;

  const EmptyPlayerCard({
    super.key,
    required this.position,
    required this.userLineup,
    required this.height,
    required this.lineupContext,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: userLineup ? () {
        Navigator.pushReplacementNamed(context, AppRoutes.playersStore, arguments: {'position': position});
      }: null,
      child: SizedBox(
        width: 559*height/800,
        height: height,
        child: Image(
          image: AssetImage('assets/placeholder.png'),
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}