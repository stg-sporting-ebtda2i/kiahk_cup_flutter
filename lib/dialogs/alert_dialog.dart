import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/widgets/widgets_dialog_button.dart';

void showAlertDialog({
  required BuildContext context,
  required String text,
  String positiveBtnText="Confirm",
  String cancelBtnText="Cancel",
  required VoidCallback positiveBtnAction,
}) {
  showDialog(
      context: context,
      builder: (BuildContext c) {
        return alertDialog(
          context: context,
          text: text,
          positiveBtnText: positiveBtnText,
          cancelBtnText: cancelBtnText,
          positiveBtnAction: positiveBtnAction,
        );
      }
  );
}

AlertDialog alertDialog({
  required BuildContext context,
  required String text,
  String positiveBtnText = "Confirm",
  String cancelBtnText = "Cancel",
  required VoidCallback positiveBtnAction,
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
            dialogButton(text: cancelBtnText, onClick: () => Navigator.pop(context), backgroundColor: Colors.grey.shade700, color: Colors.white),
            dialogButton(text: positiveBtnText, onClick: positiveBtnAction),
          ],
        ),
      ],
  );
}