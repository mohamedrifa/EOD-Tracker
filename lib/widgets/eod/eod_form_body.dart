import 'package:flutter/material.dart';
import 'elements/TextEditor.dart';
import 'elements/placeholder.dart';
import 'status_selector.dart';

class EodFormBody extends StatelessWidget {
  final TextEditingController topicController;
  final TextEditingController expectedController;
  final TextEditingController actualController;
  final TextEditingController descController;
  final String status;
  final Function(String) onStatusChange;

  const EodFormBody({
    super.key,
    required this.topicController,
    required this.expectedController,
    required this.actualController,
    required this.descController,
    required this.status,
    required this.onStatusChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [

          const Align(
            alignment: Alignment.centerLeft,
            child: RequiredLabel(text: "Topic", required: true,),
          ),
          const SizedBox(height: 8),
          Texteditor(hint: "Enter Task", controller: topicController),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const RequiredLabel(text: "Expected Time", required: true,),
                    const SizedBox(height: 6),
                    Texteditor(hint: "Expected Time", controller: expectedController),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RequiredLabel(text: "Actual Time", required: status == "Completed",),
                    const SizedBox(height: 6),
                    Texteditor(hint: "Actual Time", controller: actualController),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          const Align(
            alignment: Alignment.centerLeft,
            child: RequiredLabel(text: "Status"),
          ),
          const SizedBox(height: 10),

          StatusSelector(
            status: status,
            onChange: onStatusChange,
          ),

          const SizedBox(height: 16),

          Texteditor(
            hint: "Describe What You Worked...",
            maxlines: 5,
            controller: descController,
          ),
        ],
      ),
    );
  }
}