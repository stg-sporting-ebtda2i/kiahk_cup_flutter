import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void showLoadingDialog(BuildContext context,) {
  // showDialog(
  //   context: context,
  //   barrierDismissible: false,
  //   builder: (BuildContext context) {
  //     return PopScope(
  //       canPop: false,
  //       child: Dialog(
  //         backgroundColor: Colors.greenAccent,
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 31),
  //           child: Row(
  //             mainAxisSize: MainAxisSize.min,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               CircularProgressIndicator(
  //                 color: Colors.black,
  //                 strokeWidth: 4,
  //               ),
  //               SizedBox(width: 20),
  //               Text(
  //                 'Loading...',
  //                 style: TextStyle(
  //                   fontSize: 22,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ), // Custom or default message
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
  //   },
  // );
  EasyLoading.show(
    status: 'loading...',
  );
}

// Static method to dismiss the loading dialog
void dismissLoadingDialog(BuildContext context) {
  EasyLoading.dismiss();
  // Navigator.of(context, rootNavigator: true).pop();
}