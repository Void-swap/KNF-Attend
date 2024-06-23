import 'package:flutter/material.dart';
import 'package:kurniv_attend/screens/attendance_page.dart';

class TakeAttendanceScreen extends StatelessWidget {
  final String day;
  final List<String> days;

  TakeAttendanceScreen({required this.day, required this.days});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Take Attendance for $day'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AttendancePage(day: day, days: days),
              ),
            );
          },
          child: Text('Take Attendance'),
        ),
      ),
    );
  }
}
