import 'package:flutter/material.dart';

Widget emptyCardPlaceholder() {
  return const Image(
    image: AssetImage('assets/placeholder/empty_card_placeholder.png'),
    fit: BoxFit.cover,
    width: double.maxFinite,
    height: double.maxFinite,
  );
}

Widget errorCardPlaceholder() {
  return const Image(
    image: AssetImage('assets/placeholder/error_card_placeholder.png'),
    fit: BoxFit.cover,
    width: double.maxFinite,
    height: double.maxFinite,
  );
}

Widget loadingCardPlaceholder() {
  return const Image(
    image: AssetImage('assets/placeholder/loading_card_placeholder.png'),
    fit: BoxFit.cover,
    width: double.maxFinite,
    height: double.maxFinite,
  );
}

Widget loadingImage() {
  return const Center(
    child: CircularProgressIndicator(
      color: Colors.white,
    ),
  );
}