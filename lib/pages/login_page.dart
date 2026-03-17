import 'dart:convert';
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../utils/storage_util.dart';
import '../widgets/auth/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool loading = false;

  Future<void> login(BuildContext context) async {
    setState(() {
      loading = true;
    });

    final response = await ApiService.login(
      email: emailController.text,
      password: passwordController.text,
    );

    setState(() {
      loading = false;
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      String userId = data["id"].toString();

      await StorageUtil.saveToken(userId);

      Navigator.pushReplacementNamed(context, "/");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login Failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 237, 215),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),

              child: LoginForm(
                emailController: emailController,
                passwordController: passwordController,
                loading: loading,
                onLogin: () => login(context),
                onSignup: () {
                  Navigator.pushNamed(context, "/signup");
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}