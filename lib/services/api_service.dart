import 'dart:convert';
import 'package:http/http.dart' as http;

class GoogleSheetsService {
  static const String _spreadsheetId =
      '1kXK1x22O4N_Cj5-l6M2LoxkUzBpDhw6oJip2VgwOQQM';
  static const String _url =
      'https://script.google.com/macros/s/AKfycby97n5Of4FgDNSYDuxa_hmXBCYPYKL7NIvhyB7m-OKs4czezDL_UWZrFiSAUsMww6dw/exec'; // Replace with your script URL

  static Future<List<Map<String, String>>> fetchData() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Map<String, String>.from(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<void> submitData(
      List<Map<String, String>> attendanceData) async {
    final response = await http.post(
      Uri.parse(_url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(attendanceData),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to submit data');
    }
  }
}
