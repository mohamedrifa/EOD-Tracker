import 'package:flutter/material.dart';

import '../text_editor.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool loading;
  final VoidCallback onLogin;
  final VoidCallback onSignup;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.loading,
    required this.onLogin,
    required this.onSignup,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool hidePass = true;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            const Text(
              "EOD Tracker",
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: Color(0xffF47C20),
              ),
            ),

            const SizedBox(height: 35),

            TextEditor(controller: widget.emailController, label: "Email"),

            const SizedBox(height: 20),

            TextEditor(
              controller: widget.passwordController,
              label: "Password",
              obscureText: hidePass,
              isPassword: true,
              hideText: hidePass,
              onToggle: () {
                setState(() => hidePass = !hidePass);
              },
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffF47C20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: widget.loading ? null : widget.onLogin,
                child: Text(
                  widget.loading ? "Logging In..." : "Login",
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            TextButton(
              onPressed: widget.onSignup,
              child: const Text(
                "Don't have an account? Sign Up",
                style: TextStyle(
                  color: Color(0xffF47C20),
                  fontFamily: 'Poppins',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}