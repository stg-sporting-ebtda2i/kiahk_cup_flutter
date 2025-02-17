class Player {
  final int id;
  final String name;
  final String position;
  final int rating;
  final bool available;
  final String imgLink;
  final int price;

  Player({
    required this.id,
    required this.name,
    required this.position,
    required this.rating,
    required this.available,
    required this.imgLink,
    required this.price,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      name: json['name'],
      position: json['position'],
      rating: json['rating'],
      available: json['available'],
      imgLink: json['imgLink'],
      price: json['price'],
    );
  }
}