import 'package:flutter/material.dart';

ButtonStyle btnStyle() {
  return ElevatedButton.styleFrom(
    backgroundColor: Colors.greenAccent,
    padding: const EdgeInsets.symmetric(
      horizontal: 0,
      vertical: 9,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18),
    ),
  );
}

TextStyle btnTextStyle() {
  return TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
}