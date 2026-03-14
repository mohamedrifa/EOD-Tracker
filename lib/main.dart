import 'package:flutter/material.dart';
import './feature/calender/pages/calendar_page.dart';

void main() {
  runApp(EodApp());
}

class EodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EOD Tracker',
      home: CalendarPage(),
    );
  }
}