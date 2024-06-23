import 'package:flutter/material.dart';
import 'package:kurniv_attend/screens/attendance_detail.dart';

class AttendanceDoneScreen extends StatelessWidget {
  final String day;

  AttendanceDoneScreen({required this.day});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Done'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Attendance for $day is already recorded.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AttendanceDetailPage(day: day),
                  ),
                );
              },
              child: Text('More'),
            ),
          ],
        ),
      ),
    );
  }
}
