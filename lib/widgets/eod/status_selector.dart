import 'package:flutter/material.dart';

class StatusSelector extends StatelessWidget {
  final String status;
  final Function(String) onChange;

  const StatusSelector({
    super.key,
    required this.status,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    List<String> options = ["Yet to Start", "In Progress", "Completed"];

    return Row(
      children: options.map((value) {
        bool active = status == value;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: InkWell(
              onTap: () => onChange(value),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: active ? const Color(0xffFF8C00) : Colors.white,
                  border: Border.all(color: const Color(0xffFF8C00)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  value,
                  style: TextStyle(
                    color: active ? Colors.white : Colors.black87,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}