import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:piehme_cup_flutter/dialogs/alert_dialog.dart';
import 'package:piehme_cup_flutter/dialogs/loading.dart';
import 'package:piehme_cup_flutter/dialogs/message.dart';
import 'package:piehme_cup_flutter/services/attendance_service.dart';
import 'package:piehme_cup_flutter/widgets/widgets_dialog_button.dart';

void showAttendanceDialog({
  required List<String> list,
  required BuildContext context,
}) {
  showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return attendanceList(
          context: context,
          dialogContext: dialogContext,
          list: list,
        );
      }
  );
}

Dialog attendanceList({
  required List<String> list,
  required BuildContext dialogContext,
  required BuildContext context,
}) {
  return Dialog(
    backgroundColor: Colors.greenAccent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: Container(
      constraints: BoxConstraints(maxHeight: 600),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Select',
            style: const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              itemCount: list.length,
              itemBuilder: (c, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: dialogButton(
                    text: list[index],
                    onClick: () async {
                      Navigator.pop(dialogContext);
                      pickDate(context: context, selectedEvent: list[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}

Future<void> pickDate({
  required BuildContext context,
  required String selectedEvent,
}) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2025),
    lastDate: DateTime(2030),
    builder: (BuildContext context, Widget? child) {
      return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.black,
              onPrimary: Colors.white,
              surface: Colors.greenAccent,
              onSurface: Colors.black,
            ),
            textTheme: TextTheme(
              bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              labelLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ), child: child!
      );
    },
  );
  if (picked != null) {
    if (context.mounted) {
      showAlertDialog(
        context: context,
        text: 'Are you sure that you want to request $selectedEvent on ${DateFormat('yyyy-MM-dd').format(picked)}?',
        positiveBtnText: 'Confirm',
        positiveBtnAction: () async {
          Navigator.pop(context);
          Loading.show(() async {
            await AttendanceService.requestAttendance(selectedEvent, DateFormat('yyyy-MM-dd').format(picked));
            toast('Attendance requested successfully');
          });
        },
      );
    }
  }
}