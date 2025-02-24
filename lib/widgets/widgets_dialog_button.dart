import 'package:flutter/material.dart';

Widget dialogButton({
  required String text,
  required VoidCallback onClick,
  Color backgroundColor = Colors.black,
  Color color = Colors.white,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    ),
    onPressed: onClick,
    child: Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 21,
        color: color,
      ),
    ),
  );
}