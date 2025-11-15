import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:piehme_cup_flutter/models/user.dart';
import 'package:piehme_cup_flutter/providers/icons_text_color_provider.dart';
import 'package:piehme_cup_flutter/widgets/placeholders.dart';
import 'package:provider/provider.dart';

class UserCard extends StatefulWidget {
  final double width;
  const UserCard({
    super.key,
    required this.width,
    this.image,
    required this.user,
    this.onClick
  });

  final VoidCallback? onClick;
  final File? image;
  final User user;

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {

  late IconsTextColorProvider _colorProvider;
  late Color _color = Colors.white;

  @override
  void initState() {
    super.initState();
    _fetchTextColor();
  }

  void _fetchTextColor() async {
    _colorProvider = context.read<IconsTextColorProvider>();
    Color color = await _colorProvider.getIconTextColor(key: widget.user.iconKey, url: widget.user.iconUrl);
    setState(() {
      _color = color;
    });
  }
  
  // Card Size: H=800px, W=559px.
  @override
  Widget build(BuildContext context) {
    final cardWidth = widget.width;
    final cardHeight = cardWidth * (1266 / 900);

    return GestureDetector(
      onTap: widget.onClick,
      child: Center(
        child: SizedBox(
          width: cardWidth,
          height: cardHeight,
          child: Stack(
            children: [
              // Card Icon (Background Image)
              CachedNetworkImage(
                imageUrl: widget.user.iconUrl,
                cacheKey:widget.user.iconKey,
                width: double.infinity,
                height: double.infinity,
                errorWidget: (context, url, error) => emptyCardPlaceholder(),
                placeholder: (context, url) => loadingCardPlaceholder(),
                fit: BoxFit.fill,
              ),
              // Centered Image
              Positioned(
                top: cardHeight * (25 / 100),
                left: cardWidth * (20 / 100),
                right: cardWidth * (20 / 100),
                bottom: cardHeight * (25 / 100),
                child: widget.image != null ?
                Image.file(
                  widget.image!,
                  fit: BoxFit.scaleDown,
                ) :
                (widget.user.imageUrl != null && widget.user.imageKey != null) ? CachedNetworkImage(
                  imageUrl: widget.user.imageUrl ?? "",
                  cacheKey: widget.user.imageKey,
                  fit: BoxFit.scaleDown,
                  errorWidget: (context, url, error) => SizedBox(),
                  placeholder: (context, url) => loadingImage(),
                ) : SizedBox(),
              ),
              // Name Text
              Positioned(
                top: cardHeight * (73 / 100),
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    widget.user.name,
                    style: TextStyle(
                      fontSize: cardWidth * (9 / 100),
                      fontWeight: FontWeight.bold,
                      color: _color,
                    ),
                  ),
                ),
              ),
              // Position Text
              Positioned(
                top: cardHeight * (31 / 100),
                left: cardWidth * (17 / 100),
                child: Text(
                  widget.user.position,
                  style: TextStyle(
                    fontSize: cardWidth * (6 / 100),
                    fontWeight: FontWeight.w500,
                    color: _color,
                  ),
                ),
              ),
              // Card Rating Text
              Positioned(
                top: cardHeight * (20 / 100),
                left: cardWidth * (14 / 100),
                child: Text(
                  '${widget.user.cardRating}',
                  style: TextStyle(
                    fontSize: cardWidth * (11 / 100),
                    fontWeight: FontWeight.bold,
                    color: _color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}