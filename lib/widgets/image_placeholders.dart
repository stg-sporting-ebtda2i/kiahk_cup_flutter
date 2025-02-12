import 'package:flutter/material.dart';

Widget errorImage() {
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
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.red, fontSize: 12),
        ),
      ],
    ),
  );
}

Widget loadingImage() {
  return SizedBox(
    width: 160,
    height: 229,
    // color: Colors.grey[300], // Background color for the loading state
    child: Center(
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    ),
  );
}