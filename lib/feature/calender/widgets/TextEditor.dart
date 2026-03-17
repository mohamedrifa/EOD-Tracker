import 'package:flutter/material.dart';

class Texteditor extends StatelessWidget {
  final String hint;
  final int maxlines;
  final TextEditingController? controller;

  const Texteditor({
    super.key,
    required this.hint,
    this.maxlines = 0,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxlines == 0 ? 1 : maxlines,
      controller: controller,
      cursorColor: const Color(0xffFF8C00),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey[400],
          fontFamily: 'Poppins',
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),

        /// Border when NOT focused
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.black54,
          ),
        ),

        /// Border when focused
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xffFF8C00),
            width: 2,
          ),
        ),
      ),
    );
  }
}