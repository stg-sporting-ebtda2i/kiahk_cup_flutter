import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/states/loading_dialog.dart';

void showLoadingDialog({
  required BuildContext context
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => PopScope(
      canPop: false,
      child: LoadingDialog(),
    ),
  );
}