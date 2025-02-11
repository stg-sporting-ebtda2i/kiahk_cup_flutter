import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/models/store_item.dart';

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
          child:Image.network(
            item.imgLink,
            width: 160,
            height: 229,
            fit: BoxFit.cover, // Ensures the image fits within the given dimensions
            errorBuilder: (context, error, stackTrace) {
              // Log the error for debugging
              debugPrint('Image load error: $error');
              // Return a user-friendly error widget
              return SizedBox(
                width: 160,
                height: 229,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, color: Colors.red, size: 40), // Error icon
                    SizedBox(height: 8),
                    Text(
                      'Failed to load image',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ],
                ),
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                // If the image is fully loaded, return the child (the actual image)
                return child;
              }
              // Show a loading indicator while the image is loading
              return SizedBox(
                width: 160,
                height: 229,
                // color: Colors.grey[300], // Background color for the loading state
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                        : null, // Show progress if available
                  ),
                ),
              );
            },
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