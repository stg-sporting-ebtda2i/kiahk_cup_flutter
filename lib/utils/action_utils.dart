import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:piehme_cup_flutter/dialogs/alert_dialog.dart';
import 'package:piehme_cup_flutter/dialogs/toast_error.dart';
import 'package:piehme_cup_flutter/providers/icons_store_provider.dart';
import 'package:provider/provider.dart';

import '../providers/header_provider.dart';

class ActionUtils {

  static void confirmAction(Future<void> action, BuildContext context) {
    showAlertDialog(
        context: context,
        text: 'Are you sure that you want to continue?',
        positiveBtnText: 'Confirm',
        positiveBtnAction: () {
          performAction(action, context);
          Navigator.pop(context);
        },
        negativeBtnText: 'Cancel',
        negativeBtnAction: () {Navigator.pop(context);}
    );
  }

  static void performAction(Future<void> action, BuildContext context) async {
    EasyLoading.show(status: 'Loading...');
    try {
      await action;
    } catch(e) {
      toastError(e.toString());
    } finally {
      EasyLoading.dismiss(animation: true);
      if (context.mounted) {
        context.read<HeaderProvider>().refreshCoins();
        context.read<IconsStoreProvider>().refreshStore();
      }
    }
  }

}