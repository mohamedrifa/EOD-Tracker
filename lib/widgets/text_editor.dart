import 'package:flutter/material.dart';

class TextEditor extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final bool isPassword;
  final bool hideText;
  final VoidCallback? onToggle;

  const TextEditor({
    super.key,
    required this.controller,
    required this.label,
    this.obscureText = false,
    this.isPassword = false,
    this.hideText = false,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(fontFamily: 'Poppins'),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontFamily: 'Poppins',
          color: Color(0xffF47C20),
        ),

        // 🔶 Default Border
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.orange.shade200),
        ),

        // 🔶 Enabled Border
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.orange.shade300),
        ),

        // 🔶 Focused Border
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            color: Color(0xffF47C20),
            width: 2,
          ),
        ),

        filled: true,
        fillColor: Colors.orange.shade50,

        // 🔶 Password Toggle
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  hideText ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xffF47C20),
                ),
                onPressed: onToggle,
              )
            : null,
      ),
    );
  }
}