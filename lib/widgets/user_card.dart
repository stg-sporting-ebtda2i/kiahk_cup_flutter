import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:piehme_cup_flutter/models/user.dart';
import 'package:piehme_cup_flutter/widgets/image_placeholders.dart';

class UserCard extends StatelessWidget {
  final double width;
  const UserCard({
    super.key,
    required this.width,
    this.image,
    required this.user,
  });

  final File? image;
  final User user;

  // Card Size: H=800px, W=559px.

  @override
  Widget build(BuildContext context) {
    final cardWidth = width;
    final cardHeight = cardWidth * (800 / 559);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder<Color?>(
        future: getTextColor(url: user.iconUrl, key: user.iconKey),
        builder: (context, snapshot) {
          Color color;
          if (snapshot.connectionState == ConnectionState.waiting) {
            color = Colors.black;
          } else if (snapshot.hasError) {
            color = Colors.black;
          } else if (!snapshot.hasData) {
            color = Colors.black;
          } else {
            color = snapshot.data!;
          }
          return Center(
            child: SizedBox(
              width: cardWidth,
              height: cardHeight,
              child: Stack(
                children: [
                  // Card Icon (Background Image)
                  CachedNetworkImage(
                    imageUrl: user.iconUrl,
                    cacheKey: user.iconKey,
                    width: double.infinity,
                    height: double.infinity,
                    errorWidget: (context, url, error) => errorImage(),
                    placeholder: (context, url) => loadingImage(),
                    fit: BoxFit.fill,
                  ),
                  // Centered Image
                  Positioned(
                    top: cardHeight * (20 / 100),
                    left: cardWidth * (20 / 100),
                    right: cardWidth * (20 / 100),
                    bottom: cardHeight * (30 / 100),
                    child: image != null ?
                    Image.file(
                      image!,
                      fit: BoxFit.cover,
                    ) :
                    (user.imageUrl != null && user.imageKey != null) ? CachedNetworkImage(
                      imageUrl: user.imageUrl ?? "",
                      cacheKey: user.imageKey,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => errorImage(),
                      placeholder: (context, url) => loadingImage(),
                    ) : SizedBox(),
                  ),
                  // Name Text
                  Positioned(
                    top: cardHeight * (72 / 100),
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        user.name,
                        style: TextStyle(
                          fontSize: cardWidth * (9 / 100),
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                  ),
                  // Position Text
                  Positioned(
                    top: cardHeight * (22 / 100),
                    left: cardWidth * (17 / 100),
                    child: Text(
                      user.position,
                      style: TextStyle(
                        fontSize: cardWidth * (6 / 100),
                        fontWeight: FontWeight.w500,
                        color: color,
                      ),
                    ),
                  ),
                  // Card Rating Text
                  Positioned(
                    top: cardHeight * (12 / 100),
                    left: cardWidth * (14 / 100),
                    child: Text(
                      '${user.cardRating}',
                      style: TextStyle(
                        fontSize: cardWidth * (11 / 100),
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Future<Color> getTextColor({required String url, required String key}) async {
  final PaletteGenerator paletteGenerator =
  await PaletteGenerator.fromImageProvider(CachedNetworkImageProvider(url, cacheKey: key));
  Color? dominantColor = paletteGenerator.dominantColor?.color;
  final double? luminance = dominantColor?.computeLuminance();
  return luminance! > 0.5 ? Colors.black : Colors.white;
}