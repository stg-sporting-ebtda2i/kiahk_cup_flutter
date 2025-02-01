import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/header.dart';
import 'package:piehme_cup_flutter/lineup.dart';
import 'player_card.dart';

class Leaderboard extends StatefulWidget {
  final List<LeaderboardUser> leaderboard = <LeaderboardUser>[
    new LeaderboardUser(rank: 1, card: PlayerCard(width: 120), rating: 99),
    new LeaderboardUser(rank: 2, card: PlayerCard(width: 120), rating: 98),
    new LeaderboardUser(rank: 3, card: PlayerCard(width: 120), rating: 97),
    new LeaderboardUser(rank: 4, card: PlayerCard(width: 120), rating: 96),
    new LeaderboardUser(rank: 5, card: PlayerCard(width: 120), rating: 95),
    new LeaderboardUser(rank: 6, card: PlayerCard(width: 120), rating: 94),
    new LeaderboardUser(rank: 7, card: PlayerCard(width: 120), rating: 93),
    new LeaderboardUser(rank: 8, card: PlayerCard(width: 120), rating: 92),
    new LeaderboardUser(rank: 9, card: PlayerCard(width: 120), rating: 91),
    new LeaderboardUser(rank: 10, card: PlayerCard(width: 120), rating: 90),
  ];

  Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class LeaderboardUser {
  final int rank;
  final PlayerCard card;
  final int rating;

  LeaderboardUser({
    required this.rank,
    required this.card,
    required this.rating,
  });
}

class _LeaderboardState extends State<Leaderboard> {

  late List<LeaderboardUser> _leaderboard;

  @override
  void initState() {
    super.initState();
    _leaderboard = widget.leaderboard; // Initialize state from props
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
                Expanded(child:
                  ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: _leaderboard.length,
                    itemBuilder: (context, index) {
                      final user = _leaderboard[index];
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
            '${user.rank}',
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LineupPage(userLineup: false),
                ),
              );
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

