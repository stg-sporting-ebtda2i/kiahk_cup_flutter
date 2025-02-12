import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/routes/app_routes.dart';
import 'package:piehme_cup_flutter/widgets/image_placeholders.dart';

class PlayerCard extends StatelessWidget {
  final String id;
  final bool userLineup;

  const PlayerCard({super.key, required this.id, required this.userLineup});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: userLineup ? () {Navigator.pushNamed(context, AppRoutes.cardsStore);}: null,
      child: SizedBox(
        width: 95,
        height: 136,
        child: CachedNetworkImage(
          imageUrl: 'https://firebasestorage.googleapis.com/v0/b/quiz-fut-draft.appspot.com/o/Cards%2F1730921955710.png?alt=media&token=c3894241-c2a7-425a-83dd-63b7036e1a3b',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => errorImage(),
          placeholder: (context, url) => loadingImage(),
        ),
      ),
    );
  }
}