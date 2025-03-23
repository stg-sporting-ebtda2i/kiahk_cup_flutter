import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/dialogs/loading.dart';
import 'package:piehme_cup_flutter/providers/attendance_provider.dart';
import 'package:piehme_cup_flutter/widgets/header.dart';
import 'package:piehme_cup_flutter/widgets/requested_attendance_listitem.dart';
import 'package:provider/provider.dart';

class RequestedAttendance extends StatelessWidget {
  const RequestedAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/other_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SafeArea(child: Header()),
            Consumer<AttendanceProvider>(
                builder: (context, provider, child) {
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await Loading.show(() async {
                          await context.read<AttendanceProvider>().loadRequestedAttendances();
                        }, message: 'Loading...', delay: Duration.zero);
                      },
                      color: Colors.black,
                      backgroundColor: Colors.greenAccent,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(15),
                        itemCount: provider.requestedList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: RequestedAttendanceListItem(requestedAttendance: provider.requestedList[index]),
                          );
                        },
                      ),
                    ),
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}
