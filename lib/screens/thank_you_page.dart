import 'package:flutter/material.dart';

class ThankYouPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thank You'),
      ),
      body: Center(
        child: Text(
          'Thank you for checking the attendance!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
