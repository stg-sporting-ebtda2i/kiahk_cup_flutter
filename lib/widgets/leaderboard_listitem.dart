import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/models/leaderboard_user.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';

class LeaderboardListItem extends StatelessWidget {

  final LeaderboardUser user;

  const LeaderboardListItem({
    required super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          user.rank.toString().padLeft(2, '0'),
          style: TextStyle(
            fontSize: 23,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          width: 120,
          height: 175,
          child: user.card,
        ),
        Text(
          '${user.rating}',
          style: TextStyle(
            fontSize: 23,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.lineup, arguments: {'userLineup': false,});
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white70,
          ),
          child: Text(
            'View lienup',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}