import 'package:flutter/material.dart';

class SignupForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool loading;
  final VoidCallback onSignup;
  final VoidCallback onLogin;

  const SignupForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.loading,
    required this.onSignup,
    required this.onLogin,
  });

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
              "Create Account",
              style: TextStyle(
                fontSize: 28,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: Color(0xffF47C20),
              ),
            ),

            const SizedBox(height: 35),

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
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
                onPressed: loading ? null : onSignup,
                child: Text(
                  loading ? "Registering..." : "Sign Up",
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
              onPressed: onLogin,
              child: const Text(
                "Already have an account? Login",
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