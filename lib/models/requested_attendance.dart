import 'package:intl/intl.dart';

class RequestedAttendance {
  final int id;
  final bool approved;
  final String description;
  final String date;
  final int coins;
  final String createdAt;

  RequestedAttendance({
    required this.id,
    required this.approved,
    required this.description,
    required this.date,
    required this.coins,
    required this.createdAt
  });

  factory RequestedAttendance.fromJson(Map<String, dynamic> json) {
    return RequestedAttendance(
      id: json['id'],
      approved: json['approved'],
      description: json['description'],
      date: DateFormat('EEEE dd MMMM, yyyy').format(DateTime.parse(json['date'])),
      coins: json['coins'],
      createdAt: json['createdAt']
    );
  }

}