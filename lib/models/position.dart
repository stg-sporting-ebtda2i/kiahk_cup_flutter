class Position {
  final int id;
  final String name;
  final String price;
  bool owned;
  bool selected;

  Position({
    required this.id,
    required this.name,
    required this.price,
    this.owned = false,
    this.selected = false,
  });

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      id: json['id'],
      name: json['name'],
      price: json['price'],
    );
  }
}