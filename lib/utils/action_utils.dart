import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:piehme_cup_flutter/dialogs/alert_dialog.dart';
import 'package:piehme_cup_flutter/dialogs/loading_dialog.dart';
import 'package:piehme_cup_flutter/dialogs/message.dart';
import 'package:provider/provider.dart';

import '../providers/header_provider.dart';

class ActionUtils {
  final BuildContext context;
  final Future<void> Function() callback;
  final Future<void> Function() action;
  late int delay = 0;

  ActionUtils({
    required this.context,
    required this.action,
    required this.callback,
    required this.delay,
  });

  void confirmAction(
      {String text = 'Are you sure that you want to continue?',
      String confirmBtn = 'Confirm'}) {
    showAlertDialog(
      context: context,
      text: text,
      positiveBtnText: confirmBtn,
      positiveBtnAction: () {
        Navigator.pop(context);
        performAction(context);
      },
    );
  }

  Future<void> performAction(BuildContext context) async {
    showLoadingDialog(context: context);
    // EasyLoading.show(status: 'Loading...');
    try {
      await action();
    } catch (e) {
      toast(e.toString());
    } finally {
      Future.delayed(Duration(seconds: delay), () async {
        if (context.mounted) {
          context.read<HeaderProvider>().refreshCoins();
          await callback();
        }
        Navigator.pop(context);
        EasyLoading.dismiss(animation: true);
      });
    }
  }
}
