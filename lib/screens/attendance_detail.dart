import 'package:flutter/material.dart';

class AttendanceDetailPage extends StatelessWidget {
  final String day;

  AttendanceDetailPage({required this.day});

  @override
  Widget build(BuildContext context) {
    // Implement detailed attendance view here, similar to the AttendancePage
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Details for $day'),
      ),
      body: Center(
        child: Text(
          'Detailed attendance for $day will be shown here.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
