class CardIcon {
  final int iconId;
  final String name;
  final int price;
  final bool available;
  final String imgLink;
  bool owned;

  CardIcon({
    required this.iconId,
    required this.name,
    required this.price,
    required this.available,
    required this.imgLink,
    this.owned = false,
  });

  factory CardIcon.fromJson(Map<String, dynamic> json) {
    return CardIcon(
      // iconId: json['iconId'],
      iconId: 1,
      name: json['name'],
      price: json['price'],
      available: json['available'],
      imgLink: json['imgLink'],
    );
  }
}