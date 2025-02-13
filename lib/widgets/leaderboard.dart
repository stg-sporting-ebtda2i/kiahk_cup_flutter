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
      iconURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/CardIcons%2F1734903608232.png?alt=media&token=56ed0806-8cac-4055-a368-cea1f06f4797',
      image: null,
      imageURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/Users%2Fauto.png?alt=media&token=575a019d-e553-4be5-af05-8c50af82fdf4',
      position: 'LW',
    ), rating: 99),
    LeaderboardUser(rank: 2, card: UserCard(
      width: 120,
      name: 'Patrick Remon',
      rating: 99,
      iconURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/CardIcons%2F1730924257442.png?alt=media&token=5f9e72dc-0b24-46a8-9d58-944f647957a7',
      image: null,
      imageURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/Users%2Fauto.png?alt=media&token=575a019d-e553-4be5-af05-8c50af82fdf4',
      position: 'ST',
    ), rating: 98),
    LeaderboardUser(rank: 3, card: UserCard(
      width: 120,
      name: 'Patrick Remon',
      rating: 99,
      iconURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/CardIcons%2F1730924312862.png?alt=media&token=434e16b6-49b7-465d-856e-edeca630e895',
      image: null,
      imageURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/Users%2Fauto.png?alt=media&token=575a019d-e553-4be5-af05-8c50af82fdf4',
      position: 'ST',
    ), rating: 97),
    LeaderboardUser(rank: 4, card: UserCard(
      width: 120,
      name: 'Patrick Remon',
      rating: 99,
      iconURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/CardIcons%2F1730924440117.png?alt=media&token=5ee4d659-03ee-4146-b4c2-5dcda77febba',
      image: null,
      imageURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/Users%2Fauto.png?alt=media&token=575a019d-e553-4be5-af05-8c50af82fdf4',
      position: 'ST',
    ), rating: 96),
    LeaderboardUser(rank: 5, card: UserCard(
      width: 120,
      name: 'Patrick Remon',
      rating: 99,
      iconURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/CardIcons%2F1730924516942.png?alt=media&token=65e4489b-fd84-4916-a97c-2d6ffbcb5d5c',
      image: null,
      imageURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/Users%2Fauto.png?alt=media&token=575a019d-e553-4be5-af05-8c50af82fdf4',
      position: 'ST',
    ), rating: 95),
    LeaderboardUser(rank: 6, card: UserCard(
      width: 120,
      name: 'Patrick Remon',
      rating: 99,
      iconURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/CardIcons%2F1730924257442.png?alt=media&token=5f9e72dc-0b24-46a8-9d58-944f647957a7',
      image: null,
      imageURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/Users%2Fauto.png?alt=media&token=575a019d-e553-4be5-af05-8c50af82fdf4',
      position: 'ST',
    ), rating: 98),
    LeaderboardUser(rank: 7, card: UserCard(
      width: 120,
      name: 'Patrick Remon',
      rating: 99,
      iconURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/CardIcons%2F1730924312862.png?alt=media&token=434e16b6-49b7-465d-856e-edeca630e895',
      image: null,
      imageURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/Users%2Fauto.png?alt=media&token=575a019d-e553-4be5-af05-8c50af82fdf4',
      position: 'ST',
    ), rating: 97),
    LeaderboardUser(rank: 8, card: UserCard(
      width: 120,
      name: 'Patrick Remon',
      rating: 99,
      iconURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/CardIcons%2F1730924440117.png?alt=media&token=5ee4d659-03ee-4146-b4c2-5dcda77febba',
      image: null,
      imageURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/Users%2Fauto.png?alt=media&token=575a019d-e553-4be5-af05-8c50af82fdf4',
      position: 'ST',
    ), rating: 96),
    LeaderboardUser(rank: 9, card: UserCard(
      width: 120,
      name: 'Patrick Remon',
      rating: 99,
      iconURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/CardIcons%2F1730924516942.png?alt=media&token=65e4489b-fd84-4916-a97c-2d6ffbcb5d5c',
      image: null,
      imageURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/Users%2Fauto.png?alt=media&token=575a019d-e553-4be5-af05-8c50af82fdf4',
      position: 'ST',
    ), rating: 95),
    LeaderboardUser(rank: 10, card: UserCard(
      width: 120,
      name: 'Patrick Remon',
      rating: 99,
      iconURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/CardIcons%2F1730923050779.png?alt=media&token=9e0da66d-24d0-49ef-8547-d4c00ecc0728',
      image: null,
      imageURL: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/Users%2Fauto.png?alt=media&token=575a019d-e553-4be5-af05-8c50af82fdf4',
      position: 'ST',
    ), rating: 95),

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
