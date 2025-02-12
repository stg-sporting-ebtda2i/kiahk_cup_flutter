import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/models/leaderboard_user.dart';
import 'package:piehme_cup_flutter/widgets/header.dart';
import 'package:piehme_cup_flutter/widgets/leaderboard_listitem.dart';
import 'user_card.dart';

class Leaderboard extends StatelessWidget {
  Leaderboard({super.key});

  final List<LeaderboardUser> leaderboard = <LeaderboardUser>[
    LeaderboardUser(rank: 1, card: UserCard(
      width: 120,
      name: 'Patrick Remon',
      rating: 99,
      iconURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/CardIcons%2Ficon0.png?alt=media&token=926b31d4-7b75-4f57-ba28-28a78066628d',
      image: null,
      imageURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/Users%2Fauto.png?alt=media&token=575a019d-e553-4be5-af05-8c50af82fdf4',
      position: 'ST',
    ), rating: 99),
    LeaderboardUser(rank: 2, card: UserCard(
      width: 120,
      name: 'Patrick Remon',
      rating: 99,
      iconURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/CardIcons%2Ficon0.png?alt=media&token=926b31d4-7b75-4f57-ba28-28a78066628d',
      image: null,
      imageURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/Users%2Fauto.png?alt=media&token=575a019d-e553-4be5-af05-8c50af82fdf4',
      position: 'ST',
    ), rating: 98),
    LeaderboardUser(rank: 3, card: UserCard(
      width: 120,
      name: 'Patrick Remon',
      rating: 99,
      iconURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/CardIcons%2Ficon0.png?alt=media&token=926b31d4-7b75-4f57-ba28-28a78066628d',
      image: null,
      imageURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/Users%2Fauto.png?alt=media&token=575a019d-e553-4be5-af05-8c50af82fdf4',
      position: 'ST',
    ), rating: 97),
    LeaderboardUser(rank: 4, card: UserCard(
      width: 120,
      name: 'Patrick Remon',
      rating: 99,
      iconURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/CardIcons%2Ficon0.png?alt=media&token=926b31d4-7b75-4f57-ba28-28a78066628d',
      image: null,
      imageURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/Users%2Fauto.png?alt=media&token=575a019d-e553-4be5-af05-8c50af82fdf4',
      position: 'ST',
    ), rating: 96),
    LeaderboardUser(rank: 5, card: UserCard(
      width: 120,
      name: 'Patrick Remon',
      rating: 99,
      iconURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/CardIcons%2Ficon0.png?alt=media&token=926b31d4-7b75-4f57-ba28-28a78066628d',
      image: null,
      imageURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/Users%2Fauto.png?alt=media&token=575a019d-e553-4be5-af05-8c50af82fdf4',
      position: 'ST',
    ), rating: 95),
    LeaderboardUser(rank: 6, card: UserCard(
      width: 120,
      name: 'Patrick Remon',
      rating: 99,
      iconURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/CardIcons%2Ficon0.png?alt=media&token=926b31d4-7b75-4f57-ba28-28a78066628d',
      image: null,
      imageURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/Users%2Fauto.png?alt=media&token=575a019d-e553-4be5-af05-8c50af82fdf4',
      position: 'ST',
    ), rating: 94),
    LeaderboardUser(rank: 7, card: UserCard(
      width: 120,
      name: 'Patrick Remon',
      rating: 99,
      iconURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/CardIcons%2Ficon0.png?alt=media&token=926b31d4-7b75-4f57-ba28-28a78066628d',
      image: null,
      imageURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/Users%2Fauto.png?alt=media&token=575a019d-e553-4be5-af05-8c50af82fdf4',
      position: 'ST',
    ), rating: 93),
    LeaderboardUser(rank: 8, card: UserCard(
      width: 120,
      name: 'Patrick Remon',
      rating: 99,
      iconURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/CardIcons%2Ficon0.png?alt=media&token=926b31d4-7b75-4f57-ba28-28a78066628d',
      image: null,
      imageURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/Users%2Fauto.png?alt=media&token=575a019d-e553-4be5-af05-8c50af82fdf4',
      position: 'ST',
    ), rating: 92),
    LeaderboardUser(rank: 9, card: UserCard(
      width: 120,
      name: 'Patrick Remon',
      rating: 99,
      iconURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/CardIcons%2Ficon0.png?alt=media&token=926b31d4-7b75-4f57-ba28-28a78066628d',
      image: null,
      imageURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/Users%2Fauto.png?alt=media&token=575a019d-e553-4be5-af05-8c50af82fdf4',
      position: 'ST',
    ), rating: 91),
    LeaderboardUser(rank: 10, card: UserCard(
      width: 120,
      name: 'Patrick Remon',
      rating: 99,
      iconURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/CardIcons%2Ficon0.png?alt=media&token=926b31d4-7b75-4f57-ba28-28a78066628d',
      image: null,
      imageURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/Users%2Fauto.png?alt=media&token=575a019d-e553-4be5-af05-8c50af82fdf4',
      position: 'ST',
    ), rating: 90),
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
