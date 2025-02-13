import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:piehme_cup_flutter/widgets/image_placeholders.dart';

class StoreListItem extends StatelessWidget {
  final String imgLink;
  final int price;
  final bool owned;
  final VoidCallback buy;
  final VoidCallback sell;
  final VoidCallback select;

  const StoreListItem({
    super.key,
    required this.imgLink,
    required this.price,
    required this.owned,
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
            imageUrl: imgLink,
            width: 160,
            height: 229,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => errorImage(),
            placeholder: (context, url) => loadingImage(),
          ),
        ),
        Text(
          '$price €',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (owned) SizedBox(width: 30,),
            SizedBox(
              height: 37,
              child: ElevatedButton(
                onPressed: owned ? select : buy,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white70,
                ),
                child: Text(
                  owned ? 'Select' : 'Purchase',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            if (owned)
              SizedBox(
                width: 30,
                child: IconButton(
                  onPressed: sell,
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}