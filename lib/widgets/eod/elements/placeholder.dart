import 'package:flutter/material.dart';

class RequiredLabel extends StatelessWidget {
  final String text;

  const RequiredLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "$text ",
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
              color: Colors.black87,
            ),
          ),
          const TextSpan(
            text: "*",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xffF47C20),
            ),
          ),
        ],
      ),
    );
  }
}