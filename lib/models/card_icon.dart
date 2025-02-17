class CardIcon {
  final int id;
  final String name;
  final int price;
  final bool available;
  final String imgLink;
  bool owned;
  bool selected;

  CardIcon({
    required this.id,
    required this.name,
    required this.price,
    required this.available,
    required this.imgLink,
    this.owned = false,
    this.selected = false,
  });

  factory CardIcon.fromJson(Map<String, dynamic> json) {
    return CardIcon(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      available: json['available'],
      imgLink: json['imgLink'],
    );
  }
}