import 'package:flutter/material.dart';

AlertDialog alertDialog({
  required BuildContext context,
  required String text,
  required String positiveBtnText,
  required VoidCallback positiveBtnAction,
  required String negativeBtnText,
  required VoidCallback negativeBtnAction,
}) {
  return AlertDialog(
      title: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.greenAccent,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            dialogButton(text: negativeBtnText, onClick: negativeBtnAction),
            dialogButton(text: positiveBtnText, onClick: positiveBtnAction),
          ],
        ),
      ],
  );
}

Widget dialogButton({
  required String text,
  required VoidCallback onClick,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black,
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
        color: Colors.white,
      ),
    ),
  );
}