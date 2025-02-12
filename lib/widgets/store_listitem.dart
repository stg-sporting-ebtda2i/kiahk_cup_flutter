import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/models/store_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:piehme_cup_flutter/widgets/image_placeholders.dart';

class StoreListItem extends StatelessWidget {

  final StoreItem item;

  const StoreListItem({
    super.key,
    required this.item
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 160,
          height: 229,
          child: CachedNetworkImage(
            imageUrl: item.imgLink,
            width: 160,
            height: 229,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => errorImage(),
            placeholder: (context, url) => loadingImage(),
          ),
        ),
        Text(
          '${item.price} €',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10,),
        SizedBox(
          width: 115,
          height: 37,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white70,
            ),
            child: Text(
              item.purchased?'Select':'Purchase',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}