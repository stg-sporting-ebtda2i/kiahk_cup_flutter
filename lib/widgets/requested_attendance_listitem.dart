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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xD1FFFFFF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    requestedAttendance.description,
                    softWrap: true,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              if (requestedAttendance.approved)
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "Approved",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

            Text(
              "${requestedAttendance.coins}€",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            ],
          ),
          const SizedBox(height: 6),
          Text(requestedAttendance.date),
        ],
      ),
    );
  }
}