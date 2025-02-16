
class User {
  final int id;
  final String name;
  final int cardRating;
  final String? userImgLink;
  final double lineupRating;
  final String iconImgLink;
  final bool emptyPic;
  final String position;

  User({
    required this.id,
    required this.name,
    required this.cardRating,
    this.userImgLink,
    required this.lineupRating,
    required this.iconImgLink,
    required this.position,
    required this.emptyPic,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    String imgLink;
    bool empty;
    if (json['iconImgLink'] == null) {
      imgLink = '';
      empty = true;
    } else {
      imgLink = json['iconImgLink'];
      empty = false;
    }
    return User(
      id: json['id'],
      name: json['name'],
      cardRating: json['cardRating'],
      userImgLink: json['userImgLink'],
      lineupRating: json['lineupRating'],
      iconImgLink: imgLink,
      emptyPic: empty,
      position: json['position'],
    );
  }

}