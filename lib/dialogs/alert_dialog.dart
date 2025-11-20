import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/constants/app_colors.dart';
import 'package:piehme_cup_flutter/widgets/widgets_button.dart';
import 'package:piehme_cup_flutter/widgets/widgets_custom_outlined_button.dart';

void showAlertDialog({
  required BuildContext context,
  required String text,
  String positiveBtnText = "Confirm",
  String cancelBtnText = "Cancel",
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
    },
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
    backgroundColor: Colors.grey[900],
    elevation: 24,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
      side: BorderSide(
        color: AppColors.brand.withAlpha(77),
        width: 1.5,
      ),
    ),
    shadowColor: Colors.black.withAlpha(128),
    insetPadding: const EdgeInsets.all(30),
    contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    content: Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey[850]!,
            Colors.grey[900]!,
            Colors.grey[850]!,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header Icon
          Container(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.brand.withAlpha(155),
                    AppColors.brand
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.brand.withAlpha(102),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Icon(
                Icons.warning_rounded,
                color: Colors.black54,
                size: 35,
              ),
            ),
          ),

          // Title Text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Confirmation',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),

          // Message Text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.grey.shade300,
                fontSize: 16,
                height: 1.4,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 30),

          // Buttons Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(77),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                // Cancel Button
                Expanded(
                  child: CustomOutlinedButton(
                      onPressed: () => Navigator.pop(context)),
                ),
                const SizedBox(width: 12),

                // Confirm Button
                Expanded(
                  child: CustomButton(
                      text: positiveBtnText,
                      onPressed: positiveBtnAction,
                      isLoading: false
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
