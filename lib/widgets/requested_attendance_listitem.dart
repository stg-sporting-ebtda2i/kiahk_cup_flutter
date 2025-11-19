// If you prefer dark theme, use this version instead:

import 'package:flutter/material.dart';
import 'package:piehme_cup_flutter/models/requested_attendance.dart';

class RequestedAttendanceListItem extends StatelessWidget {
  final RequestedAttendance requestedAttendance;

  const RequestedAttendanceListItem({
    super.key,
    required this.requestedAttendance,
  });

  @override
  Widget build(BuildContext context) {
    final bool isApproved = requestedAttendance.approved;

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(
        color: isApproved ? _getApprovedDarkColor() : _getPendingDarkColor(),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(102),
            blurRadius: 12,
            offset: Offset(0, 4),
            spreadRadius: 1,
          ),
          if (isApproved)
            BoxShadow(
              color: Colors.green.withAlpha(51),
              blurRadius: 8,
              spreadRadius: 1,
            ),
        ],
        border: Border.all(
          color: isApproved ? Colors.green.withAlpha(102) : Colors.orange.withAlpha(102),
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Add onTap functionality if needed
          },
          borderRadius: BorderRadius.circular(16),
          splashColor: isApproved ? Colors.green.withAlpha(51) : Colors.orange.withAlpha(51),
          highlightColor: isApproved ? Colors.green.withAlpha(25) : Colors.orange.withAlpha(25),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Description
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(right: 12),
                        child: Text(
                          requestedAttendance.description,
                          softWrap: true,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: isApproved ? Colors.green.shade300 : Colors.grey.shade300,
                            height: 1.3,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),

                    // Status Badge
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isApproved ? Colors.green.withAlpha(51) : Colors.orange.withAlpha(51),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isApproved ? Colors.green.withAlpha(102) : Colors.orange.withAlpha(102),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isApproved ? Icons.check_circle_rounded : Icons.pending_rounded,
                            color: isApproved ? Colors.green.shade300 : Colors.orange.shade300,
                            size: 16,
                          ),
                          SizedBox(width: 6),
                          Text(
                            isApproved ? "Approved" : "Pending",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: isApproved ? Colors.green.shade300 : Colors.orange.shade300,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                // Details Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Coins Section
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isApproved ? Colors.green.withAlpha(38) : Colors.orange.withAlpha(38),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isApproved ? Colors.green.withAlpha(77) : Colors.orange.withAlpha(77),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.monetization_on_rounded,
                            color: isApproved ? Colors.green.shade300 : Colors.orange.shade300,
                            size: 18,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "${requestedAttendance.coins}€",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isApproved ? Colors.green.shade300 : Colors.orange.shade300,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Date Section
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(38),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.withAlpha(77),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            color: Colors.grey.shade400,
                            size: 16,
                          ),
                          SizedBox(width: 8),
                          Text(
                            _formatDate(requestedAttendance.date),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12),

                // Progress Indicator
                Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(77),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: isApproved ? 1.0 : 0.5,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isApproved
                              ? [Colors.green.shade500, Colors.green.shade400]
                              : [Colors.orange.shade500, Colors.orange.shade400],
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getApprovedDarkColor() {
    return Colors.green.withAlpha(13);
  }

  Color _getPendingDarkColor() {
    return Colors.orange.withAlpha(13);
  }

  String _formatDate(String date) {
    try {
      // Input: "Sunday 14 November 2023"
      // Output: "Sunday 14 Nov"

      // Take everything except the last part (year) and abbreviate month
      final parts = date.split(' ');
      if (parts.length == 4) {
        final dayName = parts[0];
        final dayNumber = parts[1];
        final month = parts[2].substring(0, 3); // Take first 3 letters of month

        return '$dayName $dayNumber $month';
      }

      return date;
    } catch (e) {
      return date;
    }
  }
}