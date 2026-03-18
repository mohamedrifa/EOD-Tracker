import 'package:eod/utils/toast_util.dart';
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/auth/signup_form.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool loading = false;

  Future<void> signup(BuildContext context) async {
    setState(() {
      loading = true;
    });

    final response = await ApiService.signup(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    setState(() {
      loading = false;
    });

    if (response.statusCode == 200) {
      ToastUtil.showSuccess(context, "Signup Successful");

      Navigator.pushReplacementNamed(context, "/login");
    } else {
      ToastUtil.showError(context, "Signup Failed: ${response.statusCode}");
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

              child: SignupForm(
                nameController: nameController,
                emailController: emailController,
                passwordController: passwordController,
                loading: loading,
                onSignup: () => signup(context),
                onLogin: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}