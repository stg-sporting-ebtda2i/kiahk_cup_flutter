import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/models/player.dart';
import 'package:piehme_cup_flutter/widgets/image_placeholders.dart';

class PlayerCard extends StatelessWidget {
  final Player player;
  final double height;
  final VoidCallback onClick;

  const PlayerCard({
    super.key,
    required this.player,
    required this.height,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: SizedBox(
        width: 559*height/800,
        height: height,
        child: CachedNetworkImage(
          imageUrl: player.imgLink,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
          errorWidget: (context, url, error) => errorImage(),
          placeholder: (context, url) => loadingImage(),
        ),
      ),
    );
  }
}