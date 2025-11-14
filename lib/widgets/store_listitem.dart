import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:piehme_cup_flutter/widgets/image_placeholders.dart';

class StoreListItem extends StatelessWidget {
  final String imageUrl;
  final String imageKey;
  final int price;
  final bool owned;
  final bool selected;
  final VoidCallback buy;
  final VoidCallback sell;
  final VoidCallback select;

  const StoreListItem({
    super.key,
    required this.imageUrl,
    required this.imageKey,
    required this.price,
    required this.owned,
    required this.selected,
    required this.buy,
    required this.sell,
    required this.select
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 160,
          height: 229,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            cacheKey: imageKey,
            width: 160,
            height: 229,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => errorImage(),
            placeholder: (context, url) => loadingImage(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$price',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 8,),
            Image.asset(
              'assets/icons/coin.png',
              width: 20,
              height: 20,
              fit: BoxFit.cover,
            ),
          ],
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (owned) SizedBox(width: 30,),
            SizedBox(
              height: 37,
              child: ElevatedButton(
                onPressed: owned ? !selected ? select : () {} : buy,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white70,
                ),
                child: Text(
                  owned ? selected ? 'Selected' : 'Select' : 'Purchase',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            if (owned)
              SizedBox(
                width: 27,
                child: IconButton(
                  onPressed: sell,
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.red,
                    size: 27,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}