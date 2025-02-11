import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';

class PlayerIcon extends StatelessWidget {
  final String id;
  final bool userLineup;

  const PlayerIcon({super.key, required this.id, required this.userLineup});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: userLineup ? () {Navigator.pushNamed(context, AppRoutes.cardsStore);}: null,
      child: Container(
        width: 95,
        height: 136,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/icon0.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}