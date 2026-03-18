import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'pages/dashboard.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/auth_guard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); 
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

        // 🔐 Protected
        '/': (context) => const AuthGuard(child: Dashboard()),
        '/settings': (context) => const AuthGuard(child: SettingsPage()),
      },
    );
  }
}