
class User {
  final int id;
  final String name;
  final int cardRating;
  final String userImgLink;
  final double lineupRating;
  final String iconImgLink;
  final String position;

  User({
    required this.id,
    required this.name,
    required this.cardRating,
    required this.userImgLink,
    required this.lineupRating,
    required this.iconImgLink,
    required this.position,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      cardRating: json['cardRating'],
      userImgLink: json['userImgLink'],
      lineupRating: json['lineupRating'],
      iconImgLink: json['iconImgLink'],
      position: json['position'],
    );
  }

}