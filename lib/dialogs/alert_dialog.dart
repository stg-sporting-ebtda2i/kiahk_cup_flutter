import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/widgets/widgets_dialog_button.dart';

void showAlertDialog({
  required BuildContext context,
  required String text,
  required String positiveBtnText,
  required VoidCallback positiveBtnAction,
  required String negativeBtnText,
  required VoidCallback negativeBtnAction,
}) {
  showDialog(
      context: context,
      builder: (BuildContext c) {
        return alertDialog(
          context: context,
          text: text,
          positiveBtnText: positiveBtnText,
          positiveBtnAction: positiveBtnAction,
          negativeBtnText: negativeBtnText,
          negativeBtnAction: negativeBtnAction
        );
      }
  );
}

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