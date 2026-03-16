import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignupPage({super.key});

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

              child: Card(
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

                          onPressed: () {
                            Navigator.pushReplacementNamed(context, "/calendar");
                          },

                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },

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
              ),
            ),
          ),
        ),
      ),
    );
  }
}