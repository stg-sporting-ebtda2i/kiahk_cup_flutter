import 'package:piehme_cup_flutter/widgets/user_card.dart';

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