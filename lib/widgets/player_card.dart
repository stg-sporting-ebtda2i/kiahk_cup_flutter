import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/models/player.dart';
import 'package:piehme_cup_flutter/widgets/placeholders.dart';

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
      child: Stack(children: [
        SizedBox(
          width: 900 * height / 1266,
          height: height,
          child: CachedNetworkImage(
            imageUrl: player.imageUrl ?? '',
            cacheKey: player.imageKey,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
            errorWidget: (context, url, error) => errorCardPlaceholder(),
            placeholder: (context, url) => loadingCardPlaceholder(),
          ),
        ),
        if (player.chemistry>0 && player.chemistry<4)
          Positioned(
            left: 0,
            bottom: 10,
            width: 20,
            height: 20,
            child: Image.asset(
              _getChemistryAsset(player.chemistry),
              fit: BoxFit.contain,
            ),
          ),
      ]),
    );
  }

  String _getChemistryAsset(int chemistry) {
    switch (chemistry) {
      case 1:
        return 'assets/icons/chemistry_1.png';
      case 2:
        return 'assets/icons/chemistry_2.png';
      case 3:
        return 'assets/icons/chemistry_3.png';
      default:
        return '';
    }
  }

}
