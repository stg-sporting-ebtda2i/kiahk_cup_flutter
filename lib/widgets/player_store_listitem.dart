import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:piehme_cup_flutter/models/player.dart';
import 'package:piehme_cup_flutter/widgets/placeholders.dart';

class PlayerStoreListItem extends StatelessWidget {
  final int index;
  final Player player;
  final bool owned;
  final bool selected;
  final VoidCallback buy;
  final VoidCallback sell;
  final VoidCallback select;

  const PlayerStoreListItem({
    super.key,
    required this.index,
    required this.player,
    required this.owned,
    required this.selected,
    required this.buy,
    required this.sell,
    required this.select,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _getCardColor(),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(77),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
        border: selected
            ? Border.all(
                color: Colors.amber,
                width: 2,
              )
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: owned ? (!selected ? select : null) : buy,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                // Player Image with enhanced styling
                _buildPlayerImage(),
                SizedBox(width: 12),

                // Player Details
                Expanded(
                  child: _buildPlayerDetails(),
                ),

                // Action Section
                _buildActionSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerImage() {
    return Stack(
      children: [
        // Main player image
        SizedBox(
          width: 115,
          height: 185,
          child: CachedNetworkImage(
            imageUrl: player.imageUrl,
            cacheKey: player.imageKey,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => errorCardPlaceholder(),
            placeholder: (context, url) =>loadingCardPlaceholder(),
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerDetails() {
    return SizedBox(
      height: 185,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Player name (if available)
          if (player.name.isNotEmpty)
            Text(
              player.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

          // Player details
          _buildDetailRow('CLUB', player.club, Icons.sports_soccer),
          _buildDetailRow('LEAGUE', player.league, Icons.emoji_events),
          _buildDetailRow('NATION', player.nationality, Icons.flag),

          // Price section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              _buildEnhancedPriceSection()
            ]
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.grey.shade400,
            size: 14,
          ),
          SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedPriceSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(77),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'PRICE',
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 8),
          Text(
            '${player.price}',
            style: TextStyle(
              color: Colors.amber.shade300,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 4),
          Image.asset(
            'assets/icons/coin.png',
            width: 16,
            height: 16,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  Widget _buildActionSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (owned)
          _buildActionButton(
            icon: Icons.delete_outline_rounded,
            color: Colors.red,
            onPressed: sell,
            tooltip: 'Sell Player',
          )
        else
          _buildActionButton(
            icon: Icons.shopping_cart_outlined,
            color: Colors.green,
            onPressed: buy,
            tooltip: 'Buy Player',
          ),
        SizedBox(height: 8),
        if (owned && !selected)
          _buildActionButton(
            icon: Icons.check_circle_outline,
            color: Colors.blue,
            onPressed: select,
            tooltip: 'Select Player',
          )
        else if (selected)
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.amber.withAlpha(50),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.amber),
            ),
            child: Icon(
              Icons.star,
              color: Colors.amber,
              size: 20,
            ),
          ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: Container(
        decoration: BoxDecoration(
          color: color.withAlpha(25),
          shape: BoxShape.circle,
          border: Border.all(color: color.withAlpha(77)),
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon, color: color, size: 20),
          padding: EdgeInsets.all(6),
          constraints: BoxConstraints(minWidth: 36, minHeight: 36),
        ),
      ),
    );
  }

  Color _getCardColor() {
    if (selected) return Colors.grey[850]!;
    return Colors.grey[900]!;
  }
}
