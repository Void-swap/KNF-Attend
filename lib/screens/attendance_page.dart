import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kurniv_attend/screens/attendance_done.dart';
import 'thank_you_page.dart';
import 'radio_button_card.dart';

class AttendancePage extends StatefulWidget {
  final String day;
  final List<String> days;

  AttendancePage({required this.day, required this.days});

  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  late List<int> selectedRadio;
  List<Map<String, dynamic>> mentorData = [];
  Map<String, List<int>> attendanceData = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response =
          await http.get(Uri.parse('https://sheetdb.io/api/v1/vwfha70gn56qt'));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<Map<String, dynamic>> fetchedData = [];

        for (var item in jsonData) {
          String mentee = item['Mentee'] ?? 'Unknown Mentee';
          String mentor = item['Mentor'] ?? 'Unknown Mentor';
          Map<String, String> dayData = {};

          item.forEach((key, value) {
            if (key != 'Mentee' && key != 'Mentor') {
              dayData[key] = value ?? '';
            }
          });

          fetchedData.add({
            'mentee': mentee,
            'mentor': mentor,
            ...dayData,
          });
        }

        setState(() {
          mentorData = fetchedData;
          attendanceData = {
            for (var day in widget.days) day: List.filled(fetchedData.length, 0)
          };

          for (int i = 0; i < fetchedData.length; i++) {
            attendanceData[widget.day]![i] =
                fetchedData[i][widget.day] == 'Absent' ||
                        fetchedData[i][widget.day] == 'Present'
                    ? 1
                    : 0;
          }

          selectedRadio = List.filled(mentorData.length, 0);

          // Check if there's already attendance data for the day
          bool hasData = mentorData.any((mentor) =>
              mentor[widget.day] != null && mentor[widget.day] != '');
          if (hasData) {
            Future.delayed(Duration.zero, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AttendanceDoneScreen(day: widget.day),
                ),
              );
            });
          }
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void updateAttendanceForSpecificDay(
      String dayToUpdate, BuildContext context) async {
    bool hasData = mentorData.any(
        (mentor) => mentor[dayToUpdate] != null && mentor[dayToUpdate] != '');

    if (hasData) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AttendanceDoneScreen(day: dayToUpdate),
        ),
      );
      return;
    }

    try {
      for (var i = 0; i < mentorData.length; i++) {
        var mentor = mentorData[i];
        var menteeName = mentor['mentee'];
        var attendance = selectedRadio[i] == 1 ? 'Absent' : 'Present';

        Map<String, dynamic> updateData = {
          'Mentee': menteeName,
          dayToUpdate: attendance,
        };

        String jsonData = json.encode(updateData);

        final response = await http.patch(
          Uri.parse(
              'https://sheetdb.io/api/v1/vwfha70gn56qt/Mentee/$menteeName'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonData,
        );

        if (response.statusCode != 200) {
          print(
              'Failed to update attendance data for $menteeName: ${response.statusCode}');
        } else {
          print('Attendance data updated successfully for $menteeName');
        }
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ThankYouPage(),
        ),
      );
    } catch (e) {
      print('Failed to update attendance data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Attendance for ${widget.day}',
          style: TextStyle(
            color: Color(0xFF100C08),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          updateAttendanceForSpecificDay(widget.day, context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Attendance data updated successfully!'),
            ),
          );
        },
        child: const Icon(
          Icons.system_update_tv,
          color: Colors.white,
        ),
        elevation: 5,
        backgroundColor: Colors.black87,
      ),
      body: Scrollbar(
        interactive: false,
        child: ListView.builder(
          itemCount: mentorData.length,
          itemBuilder: (context, index) {
            if (mentorData[index][widget.day] == "Absent") {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  color: Colors.red[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      '${mentorData[index]['mentee']} was Absent',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            } else if (mentorData[index][widget.day] == "Present") {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  color: Colors.green[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      '${mentorData[index]['mentee']} was Present',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return RadioButtonCard(
                selectedRadio: selectedRadio,
                index: index,
                mentee: mentorData[index]['mentee'],
                mentor: mentorData[index]['mentor'],
              );
            }
          },
        ),
      ),
    );
  }
}
