import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toastError(String error) {
  Fluttertoast.showToast(
    msg: error,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black54,
    textColor: Colors.white,
    fontSize: 15.0,
  );
}