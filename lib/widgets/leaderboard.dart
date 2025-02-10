import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/models/leaderboard_user.dart';
import 'package:piehme_cup_flutter/widgets/header.dart';
import 'package:piehme_cup_flutter/widgets/leaderboard_listitem.dart';
import '../player_card.dart';

class Leaderboard extends StatelessWidget {
  Leaderboard({super.key});

  final List<LeaderboardUser> leaderboard = <LeaderboardUser>[
    LeaderboardUser(rank: 1, card: PlayerCard(width: 120), rating: 99),
    LeaderboardUser(rank: 2, card: PlayerCard(width: 120), rating: 98),
    LeaderboardUser(rank: 3, card: PlayerCard(width: 120), rating: 97),
    LeaderboardUser(rank: 4, card: PlayerCard(width: 120), rating: 96),
    LeaderboardUser(rank: 5, card: PlayerCard(width: 120), rating: 95),
    LeaderboardUser(rank: 6, card: PlayerCard(width: 120), rating: 94),
    LeaderboardUser(rank: 7, card: PlayerCard(width: 120), rating: 93),
    LeaderboardUser(rank: 8, card: PlayerCard(width: 120), rating: 92),
    LeaderboardUser(rank: 9, card: PlayerCard(width: 120), rating: 91),
    LeaderboardUser(rank: 10, card: PlayerCard(width: 120), rating: 90),
  ];

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
                Expanded(child:
                ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: leaderboard.length,
                  itemBuilder: (context, index) {
                    final user = leaderboard[index];
                    return LeaderboardListItem(key: null, user: user,
                    );
                  },
                ),
                ),
              ],
            ),
          ],
        )
    );
  }
}
