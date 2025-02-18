class Price {

  final int id;
  final String name;
  final int coins;

  Price({
    required this.id,
    required this.name,
    required this.coins,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      id: json['id'],
      name: json['name'],
      coins: json['coins'],
    );
  }

}