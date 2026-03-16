import 'package:flutter/material.dart';
import './feature/calender/pages/calendar_page.dart';
import './feature/calender/pages/login_page.dart';
import './feature/calender/pages/signup_page.dart';

void main() {
  runApp(EodApp());
}

class EodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EOD Tracker',

      initialRoute: '/login',

      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/calendar': (context) => CalendarPage(),
      },
    );
  }
}