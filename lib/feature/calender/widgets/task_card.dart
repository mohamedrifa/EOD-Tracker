import 'package:flutter/material.dart';
import './../../../models/eod_model.dart';

class TaskCard extends StatelessWidget {
  final Eod task;
  final VoidCallback onTap;

  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    Color getBorderColor(){
      switch(task.status){
        case "Yet to Start": return Colors.red;
        case "In Progress": return Colors.grey;
        case "Completed": return Colors.green;
        default: return Colors.white;
      }
    }
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          margin: EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(7),
            border: Border(
              left: BorderSide(
                color: getBorderColor(),
                width: 4,
              ),
            ),
          ),
          child: Text(
            task.topic ?? "No Title",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1C2B39),
            ),
          ),
        ),
      ),
    );
  }
}