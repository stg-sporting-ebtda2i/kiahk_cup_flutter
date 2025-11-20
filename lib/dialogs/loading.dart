import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:piehme_cup_flutter/dialogs/loading_dialog.dart';
import 'package:piehme_cup_flutter/dialogs/message.dart';
import 'package:piehme_cup_flutter/services/navigation_service.dart';

class Loading {

  static bool _isLoading = false;

  static Future<void> show(Function load,
      {String message = 'Loading...',
      Duration delay = const Duration(milliseconds: 1000)}) async {
    bool done = false;

    if (delay.inMilliseconds == 0) {
      showLoadingDialog(
          context: NavigationService.navigatorKey.currentContext!);
      _isLoading = true;
      // EasyLoading.show(status: message);
    } else {
      Future.delayed(delay, () {
        if (!_isLoading && !done) {
          showLoadingDialog(
              context: NavigationService.navigatorKey.currentContext!);
          _isLoading = true;
          // EasyLoading.show(status: message);
        }
      });
    }

    try {
      await load();
    } catch (e) {
      log(e.toString());
      if (e.toString().contains("Exception")) {
        toast("Something went wrong");
      } else {
        toast(e.toString());
      }
    }
    done = true;

    Navigator.pop(NavigationService.navigatorKey.currentContext!);
    _isLoading = false;
    // EasyLoading.dismiss(animation: true);
  }
}
