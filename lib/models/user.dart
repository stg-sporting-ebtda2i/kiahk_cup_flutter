
import 'package:piehme_cup_flutter/utils/string_utils.dart';

class User {
  final int id;
  final String name;
  final int cardRating;
  final String? imageUrl;
  final String? imageKey;
  final double lineupRating;
  final String iconUrl;
  final String iconKey;
  final String position;

  User({
    required this.id,
    required this.name,
    required this.cardRating,
    required this.imageUrl,
    required this.imageKey,
    required this.lineupRating,
    required this.iconUrl,
    required this.iconKey,
    required this.position,
  });

  factory User.empty() {
    return User(
        id: -1,
        name: '',
        cardRating: 0,
        imageUrl: null,
        imageKey: null,
        lineupRating: 0,
        iconUrl: '',
        iconKey: '',
        position: ''
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: StringUtils.capitalizeWords(json['name']).split("@").first,
      cardRating: json['cardRating'],
      imageUrl: json['imageUrl'],
      imageKey: json['imageKey'],
      lineupRating: json['lineupRating'],
      iconUrl: json['iconUrl'],
      iconKey: json['iconKey'],
      position: json['position'],
    );
  }

}