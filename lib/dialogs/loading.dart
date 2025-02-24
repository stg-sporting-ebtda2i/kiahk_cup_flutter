
import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:piehme_cup_flutter/dialogs/message.dart';

class Loading {
  static Future<void> show(Function load, {String message = 'Loading...', Duration delay = const Duration(milliseconds: 1000)}) async {
    bool done = false;

    if(delay.inMilliseconds == 0) {
      EasyLoading.show(status: message);
    } else {
      Future.delayed(delay, () {
        if (!EasyLoading.isShow && !done) {
          EasyLoading.show(status: message);
        }
      });
    }

    try {
      await load();
    }catch(e) {
      log(e.toString());
      if(e.toString().contains("Exception")){
        toast("Something went wrong");
      } else {
        toast(e.toString());
      }
    }
    done = true;

    EasyLoading.dismiss(animation: true);
  }
}