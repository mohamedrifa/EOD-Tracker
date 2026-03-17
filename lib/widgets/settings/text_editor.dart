import 'package:flutter/material.dart';

class TextEditor extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscure;
  final bool enabled;

  const TextEditor({
    super.key,
    required this.controller,
    required this.label,
    this.obscure = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}