import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/models/user.dart';
import 'package:piehme_cup_flutter/providers/other_lineup_provider.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';
import 'package:piehme_cup_flutter/widgets/user_card.dart';
import 'package:provider/provider.dart';

class LeaderboardListItem extends StatelessWidget {

  final User user;
  final int index;

  const LeaderboardListItem({
    super.key,
    required this.user,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          index.toString().padLeft(2, '0'),
          style: TextStyle(
            fontSize: 23,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          width: 120,
          height: 175,
          child: UserCard(
            width: 120,
            user: user,
          ),
        ),
        Text(
          '${user.lineupRating.round()}',
          style: TextStyle(
            fontSize: 23,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        ElevatedButton(
          onPressed: () async {
              final otherLineupProvider = context.read<OtherLineupProvider>();
              await otherLineupProvider.loadLineup(user.id);
              if (!context.mounted) return;
              Navigator.pushNamed(context, AppRoutes.lineup, arguments: {'userLineup': false});
            },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white70,
          ),
          child: Text(
            'View lineup',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}