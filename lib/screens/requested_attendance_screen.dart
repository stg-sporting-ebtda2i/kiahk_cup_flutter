import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/constants/app_colors.dart';
import 'package:piehme_cup_flutter/providers/attendance_provider.dart';
import 'package:piehme_cup_flutter/widgets/header.dart';
import 'package:piehme_cup_flutter/widgets/requested_attendance_listitem.dart';
import 'package:provider/provider.dart';

import '../dialogs/attendance_dialog.dart';

class RequestedAttendance extends StatefulWidget {
  const RequestedAttendance({super.key});

  @override
  State<RequestedAttendance> createState() => _RequestedAttendanceState();
}

class _RequestedAttendanceState extends State<RequestedAttendance> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AttendanceProvider>(
        builder: (context, provider, child) {
      return Scaffold(
        floatingActionButton: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.brand.withAlpha(153),
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.brand.withAlpha(77),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(77),
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
              BoxShadow(
                color: Colors.white.withAlpha(26),
                blurRadius: 5,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            elevation: 0,
            onPressed: () => showAttendanceDialog(
              context: context,
            ),
            child: const Icon(
              Icons.add_rounded,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFF023D4D),
              Color(0xFF34443C),
              Color(0xFF230D19)
            ], begin: Alignment.topRight, end: Alignment.bottomLeft),
          ),
          child: Column(
            children: [
              SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 26),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black87,
                        Colors.black45,
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hodour',
                          style: const TextStyle(
                            fontSize: 23,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Header(),
                      ],
                    ),
                  ),
                ),
              ),
              Builder(builder: (context) {
                if (provider.isLoadingRequests && provider.requestedList.isEmpty) {
                  return _buildLoadingState();
                }
                return _buildRequestedAttendanceList(provider);
              },),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildRequestedAttendanceList(AttendanceProvider provider) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () => provider.loadRequestedAttendances(),
        color: Colors.black,
        backgroundColor: AppColors.brand,
        child: provider.requestedList.isEmpty ?
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildEmptyState()),
          ],
        ) :
        ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          itemCount: provider.requestedList.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.zero,
              child: RequestedAttendanceListItem(
                  requestedAttendance:
                  provider.requestedList[index]),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Loading animation
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(26),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.church,
                color: Colors.white.withAlpha(179),
                size: 30,
              ),
            ),
            SizedBox(height: 24),

            // Loading text
            Text(
              'Loading Requests...',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12),

            Text(
              'Getting your requests ready',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withAlpha(179),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Loading animation
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(26),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.church,
                color: Colors.white.withAlpha(179),
                size: 30,
              ),
            ),
            SizedBox(height: 24),

            // Loading text
            Text(
              'No Attendance Requested',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12),

            Text(
              'Start submitting your attendance',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withAlpha(179),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
