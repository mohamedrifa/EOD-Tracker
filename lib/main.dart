import 'package:flutter/material.dart';
import './feature/calender/pages/calendar_page.dart';
import './feature/calender/pages/login_page.dart';
import './feature/calender/pages/signup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString("token");

  runApp(EodApp(initialRoute: token == null ? '/login' : '/'));
}

class EodApp extends StatelessWidget {

  final String initialRoute;

  const EodApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EOD Tracker',

      initialRoute: initialRoute,

      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/': (context) => CalendarPage(),
      },
    );
  }
}