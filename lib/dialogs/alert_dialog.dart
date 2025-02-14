import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/widgets/widgets_dialog_button.dart';

void showAlertDialog({
  required BuildContext context,
  required String text,
  required String positiveBtnText,
  required VoidCallback positiveBtnAction,
}) {
  print('Showing dialog');
  showDialog(
      context: context,
      builder: (BuildContext c) {
        return alertDialog(
          context: context,
          text: text,
          positiveBtnText: positiveBtnText,
          positiveBtnAction: positiveBtnAction,
        );
      }
  );
}

AlertDialog alertDialog({
  required BuildContext context,
  required String text,
  required String positiveBtnText,
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
            dialogButton(text: 'Cancel', onClick: ()=> Navigator.pop(context)),
            dialogButton(text: positiveBtnText, onClick: () {print('+ve clicked'); positiveBtnAction();}),
          ],
        ),
      ],
  );
}