import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EodHeader extends StatelessWidget {
  final bool edit;
  final DateTime date;
  final VoidCallback onClose;
  final VoidCallback? onDelete;

  const EodHeader({
    super.key,
    required this.edit,
    required this.date,
    required this.onClose,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xffF47C20), Color(0xffFF9A3C)],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                edit ? "Edit End of Day Entry" : "Add End of Day Entry",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                DateFormat('MMMM d, y').format(date),
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),

          Row(
            children: [
              if (edit && onDelete != null)
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.white),
                  onPressed: onDelete,
                ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: onClose,
              ),
            ],
          )
        ],
      ),
    );
  }
}