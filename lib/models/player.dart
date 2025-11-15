import 'dart:convert';

class Player {
  final int id;
  final String name;
  final String position;
  final int rating;
  final bool available;
  final String imageUrl;
  final String imageKey;
  final int price;
  late bool owned = false;
  final String league;
  final String club;
  final String nationality;

  Player({
    required this.id,
    required this.name,
    required this.position,
    required this.rating,
    required this.available,
    required this.imageKey,
    required this.imageUrl,
    required this.price,
    required this.league,
    required this.club,
    required this.nationality,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      name: utf8.decode(json['name'].codeUnits),
      position: json['position'],
      rating: json['rating'],
      available: json['available'],
      imageUrl: json['imageUrl'],
      imageKey: json['imageKey'],
      price: json['price'],
      league: json['league'],
      club: json['club'],
      nationality: json['nationality'],
    );
  }
}